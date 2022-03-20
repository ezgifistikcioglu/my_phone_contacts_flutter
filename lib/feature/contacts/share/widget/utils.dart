import 'package:flutter/material.dart';

class Utils {
  static void showSnackbar(BuildContext context, {required String message}) {
    final snackbar = SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 20)),
      backgroundColor: Colors.red,
      duration: const Duration(milliseconds: 300),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
