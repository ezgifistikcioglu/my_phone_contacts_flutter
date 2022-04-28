import 'package:flexidate/flexidate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:my_phone_contacts/feature/language/app_localizations.dart';
import 'package:sunny_dart/sunny_dart.dart';

import '../../../core/constants/app_constants.dart';

class UpdatePersonPage extends StatefulWidget {
  const UpdatePersonPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  _UpdatePersonPageState createState() => _UpdatePersonPageState();
}

class _UpdatePersonPageState extends State<UpdatePersonPage> {
  late Contact contact;
  PostalAddress? address;
  Item? email;
  Item? phone;
  final _formKey = const GlobalObjectKey<FormState>(0);

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
    address = contact.postalAddresses.firstOrNull();
    if (address == null) {
      address = PostalAddress(label: homeText);
      contact.postalAddresses.add(address!);
    }

    email = contact.emails.firstOrNull();
    if (email == null) {
      email = Item(label: homeText);
      contact.emails.add(email!);
    }

    phone = contact.phones.firstOrNull();
    if (phone == null) {
      phone = Item(label: homeText);
      contact.phones.add(phone!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('update_contact')),
        backgroundColor: kBlueColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () async {
              _formKey.currentState!.save();
              FocusManager.instance.primaryFocus?.unfocus();
              await Future.delayed(300.ms);
              await Contacts.updateContact(contact);
            },
          ),
        ],
      ),
      body: Container(
        padding: smallEdgePadding(context),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              textFormField(
                contact.givenName,
                givenNameText,
                onSaved: (v) => contact.givenName = v,
              ),
              textFormField(
                contact.middleName ?? '',
                middleNameText,
                onSaved: (v) => contact.middleName = v,
              ),
              textFormField(
                contact.familyName ?? '',
                familyNameText,
                onSaved: (v) => contact.familyName = v,
              ),
              textFormField(
                contact.prefix ?? '',
                prefixNameText,
                onSaved: (v) => contact.prefix = v,
              ),
              textFormField(
                contact.suffix ?? '',
                suffixNameText,
                onSaved: (v) => contact.suffix = v,
              ),
              textFormField(
                phone?.value,
                phoneText,
                onSaved: (v) => phone?.value = v,
                keyboardType: TextInputType.phone,
              ),
              textFormField(
                email?.value,
                emailText,
                onSaved: (v) => email?.value = v,
                keyboardType: TextInputType.emailAddress,
              ),
              textFormField(
                contact.company ?? '',
                companyText,
                onSaved: (v) => contact.company = v,
              ),
              textFormField(contact.birthday?.dateOrValue ?? '', birthdayText,
                  onSaved: (v) {
                final parsed = FlexiDate.from(v);
                if (parsed == null) {
                  contact.birthday = null;
                } else {
                  contact.birthday = ContactDate.ofDate(
                    label: birthdayText,
                    date: parsed,
                  );
                }
              }, keyboardType: TextInputType.datetime),
              textFormField(
                contact.jobTitle ?? '',
                jobTitleText,
                onSaved: (v) => contact.jobTitle = v,
              ),
              textFormField(
                address?.street ?? '',
                streetText,
                onSaved: (v) => address?.street = v,
              ),
              textFormField(
                address?.city ?? '',
                cityText,
                onSaved: (v) => address?.city = v,
              ),
              textFormField(
                address?.region ?? '',
                regionText,
                onSaved: (v) => address?.region = v,
              ),
              textFormField(
                address?.postcode ?? '',
                postcodeText,
                onSaved: (v) => address?.postcode = v,
              ),
              textFormField(
                address?.country ?? '',
                countryText,
                onSaved: (v) => address?.country = v,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ContactBirthdayExt on Contact {
  ContactDate? get birthday =>
      dates.firstOrNull((date) => date.label?.toLowerCase() == 'birthday');

  set birthday(ContactDate? birthday) {
    if (birthday == null) {
      dates
          .removeWhere((element) => element.label?.toLowerCase() == 'birthday');
    } else {
      final bd = this.birthday;
      if (bd == null) {
        dates.add(birthday);
      } else {
        final index = dates.indexOf(bd);
        dates[index] = birthday;
      }
    }
  }
}
