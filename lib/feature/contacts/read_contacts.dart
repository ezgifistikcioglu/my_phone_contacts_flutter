import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/contacts/globals.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadContacts extends StatefulWidget {
  const ReadContacts({Key? key}) : super(key: key);

  @override
  _ReadContactsState createState() => _ReadContactsState();
}

class _ReadContactsState extends State<ReadContacts> {
  late List<Contact> listContacts;
  final _cSearch = TextEditingController();
  bool searching = false;

  @override
  void initState() {
    super.initState();
    listContacts = [];
    readContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      appBar: _appBar(context),
      body: Container(
        child: (listContacts.isNotEmpty)
            ? _listViewBuilderForContactList
            : Center(
                child: _contactProgressIndicatorColumn,
              ),
      ),
    );
  }

  Widget get _listViewBuilderForContactList => ListView.builder(
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
        trailing: _contactListTrailingCustomize(contact));
  }

  CircleAvatar _circleAvatarForList(Contact? contact) {
    return CircleAvatar(
      backgroundColor: kPinkColor,
      child: _circleAvatarFeatures(contact),
    );
  }

  Center _circleAvatarFeatures(Contact? contact) {
    return Center(
      child: (contact?.avatar != null)
          ? Image.memory(
              contact!.avatar!,
              height: 28,
              width: 28,
            )
          : Icon(
              Icons.face,
              color: kGrayColor,
            ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: appBarTitleText,
        backgroundColor: kPurpleColor,
        actions: <Widget>[_searchIconButton, _appBarRightIcon(context)],
      );

  Widget get _searchIconButton => IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (actionIcon.icon == Icons.search) {
              actionIcon = Icon(
                Icons.close,
                color: kGrayColor,
              );
              appBarTitleText = _appBarTitleTextField;
            } else {
              _cSearch.clear();
              searching = false;
              actionIcon = const Icon(
                Icons.search,
              );
              appBarTitleText = const Text("Contatos");
              // bloc.getListContact();
            }
          });
        },
      );

  Widget get _appBarTitleTextField => TextField(
        //controller: _cSearch,
        style: TextStyle(
          color: kGrayColor,
        ),
        autofocus: true,
        decoration: _appBarSearchInput,
      );

  InputDecoration get _appBarSearchInput => InputDecoration(
      prefixIcon: Icon(Icons.search, color: kGrayColor),
      hintText: searchLabelText,
      hintStyle: TextStyle(color: kGrayColor));

  Widget _appBarRightIcon(BuildContext context) => IconButton(
        icon: const Icon(Icons.more_vert_rounded),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );

  InkWell _contactListTrailingCustomize(Contact contact) => InkWell(
        child: _contactIconFeatures,
        onTap: () {
          _makePhoneCall("tel:${contact.phones.length.gcd(0)}");
        },
      );

  Icon get _contactIconFeatures => Icon(
        Icons.call,
        color: kPurpleColor,
      );

  Column get _contactProgressIndicatorColumn => Column(
        mainAxisSize: MainAxisSize.min,
        children: [_contactProgressIndicator, const Text(readContactText)],
      );

  CircularProgressIndicator get _contactProgressIndicator =>
      const CircularProgressIndicator(
        backgroundColor: Colors.red,
      );

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  readContacts() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Contacts.streamContacts().forEach((contact) {
        //print("${contact.displayName}");
        setState(() {
          listContacts.add(contact);
        });
      });
    }

    // You can manually adjust the buffer size
    //return  Contacts.streamContacts(bufferSize: 10);
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.restricted;
    } else {
      return permission;
    }
  }
}
