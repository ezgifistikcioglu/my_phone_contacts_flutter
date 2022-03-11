import 'package:flutter/material.dart';
import 'package:flutter_contact/contact.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_contact/paging_iterable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadContacts extends StatefulWidget {
  const ReadContacts({Key? key}) : super(key: key);

  @override
  _ReadContactsState createState() => _ReadContactsState();
}

class _ReadContactsState extends State<ReadContacts> {
  late List<Contact> listContacts;

  @override
  void initState() {
    super.initState();
    listContacts = [];
    readContacts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Get Phone Contact List"),
            backgroundColor: Colors.green,
          ),
          body: Container(
            child: (listContacts.length > 0)
                ? ListView.builder(
                    itemCount: listContacts.length,
                    itemBuilder: (context, index) {
                      Contact? contact = listContacts.get(index);
                      return Card(
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Center(
                                child: (contact?.avatar != null)
                                    ? Image.memory(
                                        contact!.avatar!,
                                        height: 28,
                                        width: 28,
                                      )
                                    : Icon(Icons.face),
                              ),
                            ),
                            title: Text("${contact?.displayName}"),
                            subtitle: Text((contact!.phones.length > 0)
                                ? "${contact.phones.get(0)}"
                                : "No contact"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                              onTap: () {
                                _makePhoneCall(
                                    "tel:${contact?.phones.length.gcd(0)}");
                              },
                            )),
                      );
                    })
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                        Text("reading Contacts...")
                      ],
                    ),
                  ),
          ),
        ));
  }

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
        print("${contact.displayName}");
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
