import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/contacts/read_contacts.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/share_files_widget.dart';
import 'package:my_phone_contacts/feature/language/app_localizations.dart';
import 'package:my_phone_contacts/widgets/change_language_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _cSearch = TextEditingController();
  bool searching = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      bottomNavigationBar: buildBottomBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [buildPages()],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(context.translate('app_title')),
        backgroundColor: kBlueColor,
        actions: <Widget>[
          _searchIconButton,
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
            icon: const Icon(Icons.backup),
            label: context.translate('back_up'),
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
      case 2:
        return const ShareFilesWidget();
      default:
        return Container();
    }
  }

  Widget get _searchIconButton => IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (actionIcon.icon == Icons.search) {
              actionIcon = Icon(
                Icons.close,
                color: kGrayColor,
              );
              appBarTitleText = _appBarTitleTextField;
            } else {
              _cSearch.clear();
              searching = false;
              actionIcon = const Icon(
                Icons.search,
              );
              appBarTitleText = const Text("Contatos");
              // bloc.getListContact();
            }
          });
        },
      );
  Widget _appBarRightIcon(BuildContext context) => IconButton(
        icon: const Icon(Icons.more_vert_rounded),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );

  Widget get _appBarTitleTextField => TextField(
        //controller: _cSearch,
        style: TextStyle(
          color: kGrayColor,
        ),
        autofocus: true,
        decoration: _appBarSearchInput,
      );

  InputDecoration get _appBarSearchInput => InputDecoration(
      prefixIcon: Icon(Icons.search, color: kGrayColor),
      hintText: searchLabelText,
      hintStyle: TextStyle(color: kGrayColor));
}
