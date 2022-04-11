import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';

import 'package:my_phone_contacts/feature/contacts/crud/update_person_page.dart';
import 'package:my_phone_contacts/feature/contacts/tiles.dart';
import 'package:my_phone_contacts/feature/vcf/vcard_formatter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../utils/extensions.dart';

class PersonDetailsPage extends StatefulWidget {
  static const String id = 'contact_details_screen';
  const PersonDetailsPage(
      {Key? key,
      required this.contact,
      required this.onContactDeviceSave,
      required this.contactService})
      : super(key: key);

  final Contact contact;
  final Function(Contact contact) onContactDeviceSave;
  final ContactService contactService;

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  late Contact _contact;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<dynamic> values;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
  }

  Future _openExistingContactOnDevice(BuildContext context) async {
    var contact =
        await widget.contactService.openContactEditForm(_contact.identifier);
    if (contact != null) {
      widget.onContactDeviceSave(contact);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
          title: Text(_contact.displayName ?? ''),
          backgroundColor: kBlueColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final res = await widget.contactService.deleteContact(_contact);
                if (res) {
                  Navigator.pop(context, true);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdatePersonPage(
                    contact: _contact,
                  ),
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.contact_page),
                onPressed: () => _openExistingContactOnDevice(context)),
            IconButton(
              icon: const Icon(Icons.file_present),
              onPressed: () {
                VCardFormatter().shareVCFCard(context, contact: _contact);
              },
            ),
          ]),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Contact Id: ${_contact.identifier}'),
            ),
            ListTile(
              title:
                  Text('Linked Id: ${_contact.unifiedContactId ?? 'Unknown'}'),
            ),
            ListTile(
              title: const Text('Last Updated'),
              trailing: Text(_contact.lastModified?.format() ?? 'Unknown'),
            ),
            ListTile(
              title: const Text('Name'),
              trailing: Text(_contact.givenName ?? ''),
            ),
            ListTile(
              title: const Text('Middle name'),
              trailing: Text(_contact.middleName ?? ''),
            ),
            ListTile(
              title: const Text('Family name'),
              trailing: Text(_contact.familyName ?? ''),
            ),
            ListTile(
              title: const Text('Prefix'),
              trailing: Text(_contact.prefix ?? ''),
            ),
            ListTile(
              title: const Text('Suffix'),
              trailing: Text(_contact.suffix ?? ''),
            ),
            for (final d in (_contact.dates))
              ListTile(
                title: Text(d.label ?? ''),
                trailing: Text(d.date?.format() ?? ''),
              ),
            ListTile(
              title: const Text('Company'),
              trailing: Text(_contact.company ?? ''),
            ),
            ListTile(
              title: const Text('Job'),
              trailing: Text(_contact.jobTitle ?? ''),
            ),
            AddressesTile(_contact.postalAddresses),
            ItemsTile(_formKey, _contact.phones, 'Phones', () async {
              _contact = await Contacts.updateContact(_contact);
              setState(() {});
              widget.onContactDeviceSave(_contact);
            }),
            ItemsTile(_formKey, _contact.emails, 'Emails', () async {
              _contact = await Contacts.updateContact(_contact);
              setState(() {});
              widget.onContactDeviceSave(_contact);
            })
          ],
        ),
      ),
    );
  }
}
