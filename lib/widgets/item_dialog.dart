import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';

class ItemDialog extends StatelessWidget {
  const ItemDialog({
    Key? key,
    required this.path,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String path;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Image.asset(
              'assets/icons/$path',
            ),
          ),
          Padding(
            padding: smallEdgePadding(context),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
