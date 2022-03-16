import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/contacts/add_contact.dart';
import 'package:my_phone_contacts/feature/contacts/dump_contact_list.dart';
import 'package:my_phone_contacts/feature/contacts/globals.dart';
import 'package:my_phone_contacts/feature/contacts/read_contacts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _cSearch = TextEditingController();
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [ReadContacts()],
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
