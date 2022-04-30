import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:full_text_search/searches.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/share_files_widget.dart';
import 'package:my_phone_contacts/feature/language/app_localizations.dart';
import 'package:my_phone_contacts/widgets/change_language_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunny_dart/extensions.dart';
import 'package:sunny_dart/helpers/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../feature/contacts/crud/person_details_page.dart';
import '../../feature/vcf/vcard_formatter.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool searching = false;
  Uint8List? image;
  int index = 0;
  bool? hasPermission;
  late ContactService _contactService;
  late List<Contact> listContacts;
  final String _searchTerm = '';

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _askPermissions();
    _contactService = UnifiedContacts;
    listContacts = [];
  }

  Future<void> _askPermissions() async {
    PermissionStatus? permissionStatus;
    while (permissionStatus != PermissionStatus.granted) {
      try {
        permissionStatus = await _getContactPermission();
        if (permissionStatus != PermissionStatus.granted) {
          hasPermission = false;
          _handleInvalidPermissions(permissionStatus);
        } else {
          hasPermission = true;
        }
      } catch (e) {
        if (await showPlatformDialog(
                context: context,
                builder: (context) {
                  return PlatformAlertDialog(
                    title: const Text('Contact Permissions'),
                    content: const Text(
                        'We are having problems retrieving permissions.  Would you like to '
                        'open the app settings to fix?'),
                    actions: [
                      PlatformDialogAction(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Close'),
                      ),
                      PlatformDialogAction(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Settings'),
                      ),
                    ],
                  );
                }) ==
            true) {
          await openAppSettings();
        }
      }
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final result = await Permission.contacts.request();
      return result;
    } else {
      return status;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'Access to location data denied',
          details: null);
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: 'PERMISSION_DISABLED',
          message: 'Location data is not available on device',
          details: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        bottomNavigationBar: buildBottomBar(),
        body: buildPages(),
        floatingActionButton: _floatingActionButton);
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(context.translate('get_contact_list')),
        backgroundColor: kBlueColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.language,
            ),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => const ChangeLanguageDialog(),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.file_present,
            ),
            onPressed: () {
              VCardFormatter().shareVCFList(listContacts);
            },
          ),
        ],
      );

  Widget buildBottomBar() => BottomNavigationBar(
        backgroundColor: kBlueColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.contact_page_sharp),
            label: context.translate('get_contacts'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.share),
            label: context.translate('share_files'),
          ),
        ],
        onTap: (int index) => setState(() => this.index = index),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return Container(
          child: (listContacts.isNotEmpty)
              ? Column(
                  children: [
                    Text(
                      "${context.translate('total_contact')} ${listContacts.length}",
                      style: newsletterTextStyle(kPurpColor, 15, null, null),
                    ),
                    Expanded(child: _listViewBuilderForContactList()),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(getMobileMaxHeight(context)),
                  child: _contactProgressIndicatorColumn,
                ),
        );
      case 1:
        return const ShareFilesWidget();
      default:
        return Container();
    }
  }

  ListView _listViewBuilderForContactList() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: listContacts.length,
      itemBuilder: (context, index) {
        Contact? contact = listContacts.get(index);
        image = contact!.avatar;
        return Card(
            child: (contact.phones.isNotNullOrEmpty)
                ? _listTileForContactList(contact)
                : null);
      });

  Widget _listTileForContactList(Contact? contact) {
    return ListTile(
        leading: (contact!.avatar == null)
            ? CircleAvatar(
                backgroundColor: kBlueColor,
                child: Icon(
                  Icons.person,
                  color: kPurpColor,
                ))
            : CircleAvatar(backgroundImage: MemoryImage(image!)),
        title: Text("${contact.displayName}"),
        subtitle: Text((contact.phones.isNotEmpty)
            ? "${contact.phones.get(0)}"
            : "No contact"),
        onTap: () async {
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
        children: [_contactProgressIndicator, const Text(readContactText)],
      );

  Widget get _contactProgressIndicator => const Center(
        child: CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(133, 83, 171, 1),
          color: Color.fromRGBO(104, 200, 205, 1),
        ),
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

  FloatingActionButton get _floatingActionButton => FloatingActionButton(
        onPressed: () {
          setState(() {
            refreshContacts(true);
          });
        },
        backgroundColor: kBlueColor,
        tooltip: 'Refresh',
        child: Icon(
          Icons.refresh,
          color: kPurpColor,
        ),
      );
}
