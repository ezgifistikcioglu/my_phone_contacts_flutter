import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const TextfieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        style: TextStyle(
          color: kBlackColor,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: enterMessageText,
          hintStyle: TextStyle(color: kGrayColor),
          enabledBorder: _outlineInputBorder,
          focusedBorder: _outlineInputBorder,
        ),
      );

  OutlineInputBorder get _outlineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: _borderSide,
      );

  BorderSide get _borderSide => BorderSide(
        color: kPurpColor,
      );
}
