import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_contact/flutter_contact.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  Contact contact = Contact();
  PostalAddress address = PostalAddress(label: 'Home');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: addContactAppBarTitleText,
        backgroundColor: kPurpleColor,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _formKey.currentState!.save();
              contact.postalAddresses = [address];
              Contacts.addContact(contact);
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.save, color: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: smallPadding(context),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'First name', icon: Icon(Icons.person)),
                onSaved: (v) => contact.givenName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Last name', icon: Icon(Icons.person)),
                onSaved: (v) => contact.familyName = v,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Phone', icon: Icon(Icons.phone)),
                onSaved: (v) => contact.phones = [
                  if (v != null && v.isNotEmpty) Item(label: 'mobile', value: v)
                ],
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'E-mail', icon: Icon(Icons.email)),
                onSaved: (v) => contact.emails = [
                  if (v != null && v.isNotEmpty) Item(label: 'work', value: v)
                ],
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Company', icon: Icon(Icons.corporate_fare)),
                onSaved: (v) => contact.company = v,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Work', icon: Icon(Icons.work)),
                onSaved: (v) => contact.jobTitle = v,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
