import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/contacts/add_contact.dart';
import 'package:my_phone_contacts/feature/contacts/read_contacts.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/share_files_widget.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/share_text_widget.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPurpleColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactPage()),
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: appBarTitleText,
        backgroundColor: kPurpleColor,
        actions: <Widget>[_searchIconButton, _appBarRightIcon(context)],
      );

  Widget buildBottomBar() => BottomNavigationBar(
        backgroundColor: kPurpleColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page_sharp),
            label: 'Get contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.link),
            label: 'Share text',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Share files',
          ),
        ],
        onTap: (int index) => setState(() => this.index = index),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return const ReadContacts();
      case 1:
        return const ShareTextWidget();
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
