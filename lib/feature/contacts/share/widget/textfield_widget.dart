import 'package:flutter/gestures.dart';
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
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: 'Enter Caption',
          hintStyle: TextStyle(color: kGrayColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: kPinkColor,
            ),
          ),
        ),
      );
}
