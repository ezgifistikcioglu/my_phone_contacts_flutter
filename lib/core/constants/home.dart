import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/contacts/crud/read_contacts.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/share_files_widget.dart';
import 'package:my_phone_contacts/feature/language/app_localizations.dart';
import 'package:my_phone_contacts/widgets/change_language_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool searching = false;
  int index = 0;
  bool? hasPermission;
  late List<Contact> filteredContacts;
  final List<Contact> contacts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts = [];
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus? permissionStatus;
    while (permissionStatus != PermissionStatus.granted) {
      try {
        permissionStatus = await _getContactPermission();
        if (permissionStatus != PermissionStatus.granted) {
          hasPermission = false;
          _handleInvalidPermissions(permissionStatus);
        } else {
          hasPermission = true;
        }
      } catch (e) {
        if (await showPlatformDialog(
                context: context,
                builder: (context) {
                  return PlatformAlertDialog(
                    title: const Text('Contact Permissions'),
                    content: const Text(
                        'We are having problems retrieving permissions.  Would you like to '
                        'open the app settings to fix?'),
                    actions: [
                      PlatformDialogAction(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Close'),
                      ),
                      PlatformDialogAction(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Settings'),
                      ),
                    ],
                  );
                }) ==
            true) {
          await openAppSettings();
        }
      }
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final result = await Permission.contacts.request();
      return result;
    } else {
      return status;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'Access to location data denied',
          details: null);
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: 'PERMISSION_DISABLED',
          message: 'Location data is not available on device',
          details: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      bottomNavigationBar: buildBottomBar(),
      body: buildPages(),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: appBarTitleText,
        backgroundColor: kBlueColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.language,
            ),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => const ChangeLanguageDialog(),
              );
            },
          ),
          _appBarRightIcon(context)
        ],
      );

  Widget buildBottomBar() => BottomNavigationBar(
        backgroundColor: kBlueColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.contact_page_sharp),
            label: context.translate('get_contacts'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.share),
            label: context.translate('share_files'),
          ),
        ],
        onTap: (int index) => setState(() => this.index = index),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return const ReadContacts();
      case 1:
        return const ShareFilesWidget();
      default:
        return Container();
    }
  }

  Widget _appBarRightIcon(BuildContext context) => IconButton(
        icon: const Icon(Icons.more_vert_rounded),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
}
