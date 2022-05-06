import 'package:flutter/material.dart';
import 'package:flutter_contact/contact.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/vcf/vcard_formatter.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileOperationsScreen extends StatefulWidget {
  const FileOperationsScreen({
    Key? key,
    required this.contacts,
  }) : super(key: key);
  final List<Contact> contacts;
  final String title = "File Operations";

  @override
  _FileOperationsScreenState createState() => _FileOperationsScreenState();
}

class _FileOperationsScreenState extends State<FileOperationsScreen> {
  String fileContents = "No Data";
  List listFiles = [];

  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  void _listofFiles() async {
    String directory = (await getExternalStorageDirectory())!.path;
    setState(() {
      listFiles = Directory("$directory/")
          .listSync(); //use your folder name insted of resume.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "List Of Files",
                    style: TextStyle(color: kPurpColor, fontSize: 20),
                  )))),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listFiles.length,
                itemBuilder: (context, index) {
                  String path = listFiles[index].path;
                  String fileName = path.substring(path.lastIndexOf("/") + 1);
                  return Card(
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(fileName),
                      onTap: () {
                        VCardFormatter().shareVCFList(widget.contacts, index);
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
