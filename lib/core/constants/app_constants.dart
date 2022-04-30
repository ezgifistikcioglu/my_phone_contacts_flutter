import 'package:flutter/material.dart';

Color kBackgroundColor = const Color.fromRGBO(196, 128, 4, 1);
Color kPrimaryColor = const Color.fromRGBO(255, 183, 3, 1);
Color kSecondaryColor = const Color.fromRGBO(96, 108, 56, 1);
Color kSecondarColor = const Color.fromRGBO(40, 54, 24, 1);
Color kPinkColor = const Color.fromRGBO(113, 63, 71, 1);
Color kBlueColor = const Color.fromRGBO(104, 200, 205, 1);
Color kBlueGrayColor = const Color.fromARGB(255, 161, 196, 199);
Color kPurpColor = const Color.fromRGBO(133, 83, 171, 1);
Color kDangerColor = const Color.fromRGBO(249, 77, 30, 1);
Color kGrayColor = const Color.fromRGBO(166, 177, 187, 1);
Color kBlackColor = const Color.fromRGBO(0, 0, 0, 1);
Color kBlack2Color = const Color.fromRGBO(0, 10, 10, 80);
Color kCaptionColor = const Color.fromRGBO(163, 177, 187, 1);

/// Strings
const String readContactText = "Reading Contacts...";
Widget addContactAppBarTitleText = const Text("Select Contact");
const String searchLabelText = "Search contact name";
const String shareMessageText = 'Share message';
const String enterMessageText = 'Enter a message you want to send';
const String homeText = 'home';
const String givenNameText = 'First Name';
const String middleNameText = 'Middle Name';
const String familyNameText = 'Family Name';
const String prefixNameText = 'Prefix Name';
const String suffixNameText = 'Suffix Name';
const String phoneText = 'Phone';
const String emailText = 'E-mail';
const String companyText = 'Company Name';
const String birthdayText = 'Birthday';
const String jobTitleText = 'Job Title';
const String streetText = 'Street';
const String cityText = 'City';
const String regionText = 'Region';
const String postcodeText = 'Postal Code';
const String countryText = 'Country';
const String unknownText = '';
const String lastUpdatedText = 'Last Updated';
const String addressesText = 'Addresses';

/// Icons
Icon actionIcon = const Icon(Icons.search);

/// MediaQuery
double getMobileMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.6;

double getMobileMaxHeight(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.32;

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// SizedBox
SizedBox get sizedBoxFive => const SizedBox(height: 5);
SizedBox get sizedBoxTwenty => const SizedBox(height: 20);

/// Repetitive
BoxShadow emailContainerBoxShadow(Color color) =>
    BoxShadow(color: color, offset: const Offset(0, 8), blurRadius: 8);

TextStyle textStyleForEmailBox({double? fontSize, Color? color}) =>
    TextStyle(fontSize: fontSize, color: color);
TextStyle newsletterTextStyle(Color? color, double? fontSize,
        FontStyle? fontStyle, FontWeight? fontWeight) =>
    TextStyle(
        color: color,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontSize: fontSize ?? 20,
        fontWeight: fontWeight ?? FontWeight.normal);

TextFormField textFormField(String? initialValue, String? decoration,
    {TextInputType? keyboardType, Function(String?)? onSaved}) {
  return TextFormField(
    initialValue: initialValue ?? '',
    decoration: InputDecoration(labelText: decoration ?? ''),
    keyboardType: keyboardType ?? TextInputType.text,
    onSaved: onSaved,
  );
}

Widget createIcon(IconData? icon, Color color, {double? size}) => Icon(
      icon,
      color: color,
      size: size ?? 24.0,
    );
EdgeInsetsGeometry smallPadding(BuildContext context) =>
    EdgeInsets.all(getHeight(context) * 0.02);
EdgeInsets smallEdgePadding(BuildContext context) =>
    EdgeInsets.all(getHeight(context) * 0.02);

Widget listTileForDetailPerson(String title, String? trailing) {
  return ListTile(
    title: Text(
      title,
      textScaleFactor: 1.0,
      style: TextStyle(fontWeight: FontWeight.bold, color: kBlack2Color),
    ),
    trailing: Text(trailing ?? unknownText),
  );
}
