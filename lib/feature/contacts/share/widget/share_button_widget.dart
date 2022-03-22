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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shadowColor: kPinkColor),
        label: const Text('SHARE', style: TextStyle(fontSize: 20)),
        icon: const Icon(Icons.share),
        onPressed: onClicked,
      );
}
