import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:full_text_search/full_text_search.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/contacts/crud/person_details_page.dart';
import 'package:sunny_dart/sunny_dart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../vcf/vcard_formatter.dart';

class ReadContacts extends StatefulWidget {
  static const String id = 'contacts_screen';
  const ReadContacts({Key? key}) : super(key: key);

  @override
  _ReadContactsState createState() => _ReadContactsState();
}

class _ReadContactsState extends State<ReadContacts> {
  late List<Contact> listContacts;
  late ContactService _contactService;
  late Contact? _contact;
  String? searchTerm;
  int index = 0;
  final String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    listContacts = [];
    _contactService = UnifiedContacts;
    refreshContacts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refreshContacts([bool showIndicator = true]) async {
    if (showIndicator) {
      setState(() {});
    }
    List<Contact> _newList;
    if (_searchTerm.isNotNullOrBlank) {
      _newList = [
        ...await FullTextSearch<Contact>.ofStream(
          term: _searchTerm,
          items: _contactService.streamContacts(),
          tokenize: (contact) {
            return [
              contact.givenName,
              contact.familyName,
              ...contact.phones
                  .expand((number) => tokenizePhoneNumber(number.value)),
            ].where((s) => s != null && s != '').toList();
          },
          ignoreCase: true,
          isMatchAll: true,
          isStartsWith: true,
        ).execute().then((results) => [
              for (var result in results) result.result,
            ])
      ];
    } else {
      final contacts = _contactService.listContacts(
          withUnifyInfo: true,
          withThumbnails: true,
          withHiResPhoto: false,
          sortBy: const ContactSortOrder.firstName());
      var tmp = <Contact>[];
      while (await contacts.moveNext()) {
        (await contacts.current)?.let((self) => tmp.add(self));
      }
      _newList = tmp;
    }
    setState(() {
      if (showIndicator) {}
      listContacts = _newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: (listContacts.isNotEmpty)
          ? Column(
              children: [
                Text(
                  "Your total contact number: ${listContacts.length}",
                  style: newsletterTextStyle(kPurpColor, 15, null, null),
                ),
                IconButton(
                  icon: const Icon(Icons.file_present),
                  onPressed: () {
                    VCardFormatter().shareAllContactVCFCard(context,
                        listContacts: listContacts);
                  },
                ),
                _listViewBuilderForContactList(),
              ],
            )
          : Padding(
              padding: EdgeInsets.only(
                  top: getMobileMaxWidth(context),
                  left: getMobileMaxHeight(context)),
              child: _contactProgressIndicatorColumn,
            ),
    );
  }

  ListView _listViewBuilderForContactList() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listContacts.length,
      itemBuilder: (context, index) {
        Contact? contact = listContacts.get(index);
        return Card(
          child: _listTileForContactList(contact),
        );
      });

  Widget _listTileForContactList(Contact? contact) {
    return ListTile(
        leading: _circleAvatarForList(contact),
        title: Text("${contact?.displayName}"),
        subtitle: Text((contact!.phones.isNotEmpty)
            ? "${contact.phones.get(0)}"
            : "No contact"),
        onTap: () async {
          _contact = await _contactService.getContact(contact.identifier!);

          final res = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return PersonDetailsPage(
                contact: contact,
                onContactDeviceSave: contactOnDeviceHasBeenUpdated,
                contactService: _contactService);
          }));
          if (res != null) {
            await refreshContacts();
          }
        },
        trailing: _contactListTrailingCustomize(contact));
  }

  Widget _circleAvatarForList(Contact? contact) {
    return CircleAvatar(
      backgroundColor: kBlueColor,
      //backgroundImage: NetworkImage(profile),
      child: _circleAvatarFeatures(contact),
    );
  }

  Widget _circleAvatarFeatures(Contact? contact) {
    return (contact?.avatar != null)
        ? Image.memory(
            contact!.avatar!,
            height: 28,
            width: 28,
          )
        : Icon(
            Icons.face,
            color: kPurpColor,
          );
  }

  InkWell _contactListTrailingCustomize(Contact contact) => InkWell(
        child: _contactIconFeatures,
        onTap: () {
          _makePhoneCall("tel://${contact.phones.first.value}");
        },
      );

  Icon get _contactIconFeatures => Icon(
        Icons.call,
        color: kBlueColor,
      );

  Widget get _contactProgressIndicatorColumn => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_contactProgressIndicator, const Text(readContactText)],
      );

  Widget get _contactProgressIndicator => const CircularProgressIndicator(
        backgroundColor: Colors.red,
      );

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void contactOnDeviceHasBeenUpdated(Contact contact) {
    setState(() {
      var id =
          listContacts.indexWhere((c) => c.identifier == contact.identifier);
      listContacts[id] = contact;
    });
  }
}
