import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';

class ShareButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const ShareButtonWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: kBlueColor,
            padding: smallEdgePadding(context),
            shadowColor: kPinkColor),
        label: const Text(shareMessageText, style: TextStyle(fontSize: 15)),
        icon: const Icon(Icons.share),
        onPressed: onClicked,
      );
}
