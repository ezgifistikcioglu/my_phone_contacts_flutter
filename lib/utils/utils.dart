import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackbar(BuildContext context, {required String message}) {
    final snackbar = SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 20)),
      backgroundColor: Colors.red,
      duration: const Duration(milliseconds: 500),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static Future<List<String>> pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    List<String>? filesss =
        result?.files.map((file) => file.path).cast<String>().toList();

    if (filesss == null) {
      return <String>[];
    }
    return filesss;
  }
}
