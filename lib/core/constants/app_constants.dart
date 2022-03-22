import 'package:flutter/material.dart';

Color kBackgroundColor = const Color.fromRGBO(196, 128, 4, 1);
Color kPrimaryColor = const Color.fromRGBO(255, 183, 3, 1);
Color kSecondaryColor = const Color.fromRGBO(96, 108, 56, 1);
Color kSecondarColor = const Color.fromRGBO(40, 54, 24, 1);
Color kPinkColor = const Color.fromRGBO(113, 63, 71, 1);
Color kBlueColor = const Color.fromRGBO(104, 200, 205, 1);
Color kPurpColor = const Color.fromRGBO(133, 83, 171, 1);
Color kDangerColor = const Color.fromRGBO(249, 77, 30, 1);
Color kGrayColor = const Color.fromRGBO(166, 177, 187, 1);
Color kBlackColor = const Color.fromRGBO(0, 0, 0, 1);
Color kCaptionColor = const Color.fromRGBO(163, 177, 187, 1);

/// Strings
const String readContactText = "Reading Contacts...";
Widget appBarTitleText = const Text("Get Phone Contact List");
Widget addContactAppBarTitleText = const Text("Select Contact");
const String searchLabelText = "Search contact name";

/// Icons
Icon actionIcon = const Icon(Icons.search);

/// MediaQuery
double getMobileMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.5;

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
Widget createIcon(IconData? icon, Color color, {double? size}) => Icon(
      icon,
      color: color,
      size: size ?? 24.0,
    );
EdgeInsetsGeometry smallPadding(BuildContext context) =>
    EdgeInsets.all(getHeight(context) * 0.02);
