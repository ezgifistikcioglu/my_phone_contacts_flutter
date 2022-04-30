library vcard;

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:flutter_contact/contacts.dart';

class VCardFormatter {
  void shareVCFCard(BuildContext context, {required Contact contact}) async {
    final Contact _contact = contact;
    try {
      var _data = _vcfTemplate(_contact);
      var _vcf = await _createFile(_data!);
      await _readFile();
      _vcf = await _changeExtenstion(".vcf");
      ShareExtend.share(_vcf.path, "file");
    } catch (e) {
      print("Error Creating VCF File $e");
      return null;
    }
  }

  void shareAllContactVCFCard(BuildContext context,
      {required List<Contact?>? listContacts}) async {
    List<Contact?>? _contacts = listContacts;
    try {
      for (var i = 0; i < listContacts!.length; i++) {
        var _data = _vcfTemplate(_contacts!.get(i));
        var _vcf = await _createFile(_data!);
        await _readFile();
        _vcf = await _changeExtenstion(".vcf");
        ShareExtend.share(_vcf.path, "file");
        final str = await _vcf.readAsString();
        log(str);
      }
    } catch (e) {
      print("Error Creating VCF File $e");
      return null;
    }
  }

  void shareVCFList(List<Contact> contacts) async {
    String allContacts = "";

    for (var contact in contacts) {
      final String? data = _vcfTemplate(contact);
      allContacts = allContacts + data!;
    }

    File _vcf = await _createFile(allContacts);
    await _readFile();
    _vcf = await _changeExtenstion(".vcf");
    final str = await _vcf.readAsString();
    log(str);
    ShareExtend.share(_vcf.path, "file");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/contact.txt').create(recursive: true);
  }

  Future<String> _readFile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      print("Contents: $contents");
      return contents;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<File> _createFile(String data) async {
    final file = await _localFile;
    print("Data: $data");
    return file.writeAsString(data);
  }

  Future<File> _changeExtenstion(String ext) async {
    final file = await _localFile;
    var _newFile = file.renameSync(file.path.replaceAll(".txt", ext));
    print("New Path: ${_newFile.path}");
    return _newFile;
  }

  String? _vcfTemplate(Contact? contact) {
    final Contact? _contact = contact;
    try {
      String str = "";
      str += "BEGIN:VCARD\n";

      str += "VERSION:3.0\n";

      str += "N:${_contact!.familyName ?? ""};${_contact.givenName ?? ""};;;\n";

      str +=
          "FN:${(_contact.givenName ?? "") + " " + (_contact.familyName ?? "")}\n";

      if (_contact.company != null && _contact.company!.isNotEmpty) {
        str += "ORG:${_contact.company ?? ""}\n";
      }

      if (_contact.jobTitle != null && _contact.jobTitle!.isNotEmpty) {
        str += "TITLE:${_contact.jobTitle ?? ""}\n";
      }

      if (_contact.phones.isNotEmpty) {
        int _index = 1;
        for (var _item in _contact.phones) {
          str +=
              "TEL;PREF=${_index.toString()};TYPE=${_item.label?.toUpperCase()}:${_item.value ?? ""}\n";
          print("Added => Phone ${_item.label ?? ""} | ${_item.value ?? ""}");
          _index++;
        }
      }

      if (_contact.emails.isNotEmpty) {
        int _index = 1;
        for (var _item in _contact.emails) {
          str +=
              "EMAIL;PREF=${_index.toString()};TYPE=${_item.label ?? ""}:${_item.value ?? ""}\n";
          print("Added => Email ${_item.label ?? ""} | ${_item.value ?? ""}");
          _index++;
        }
      }

      if (_contact.postalAddresses.isNotEmpty) {
        int _index = 1;
        for (var _item in _contact.postalAddresses) {
          str +=
              "ADR;PREF=${_index.toString()};TYPE=${_item.label ?? ""}:;;${_item.street ?? ""}, ;${_item.city ?? ""};${_item.region ?? ""};${_item.postcode ?? ""};${_item.country ?? ""}\n";
          print("Added => Address ${_item.label ?? ""}");
          _index++;
        }
      }

      str += "REV:20080424T195243Z\n";

      str += "END:VCARD\n\n";

      return str;
    } catch (e) {
      print("Error Creating VCF Data $e");
      return null;
    }
  }
}
