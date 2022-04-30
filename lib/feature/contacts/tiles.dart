import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';

import '../../core/constants/app_constants.dart';

class ItemsTile extends StatefulWidget {
  const ItemsTile(this._items, this._title, this.onChange, {Key? key})
      : super(key: key);

  final Iterable<Item> _items;
  final String _title;
  final VoidCallback onChange;

  @override
  _ItemsTileState createState() => _ItemsTileState();
}

class _ItemsTileState extends State<ItemsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        listTileForDetailPerson(widget._title, ""),
        Column(
          children: widget._items
              .map(
                (i) => Padding(
                  padding: smallEdgePadding(context),
                  child: ListTile(
                    title: Text(
                      i.label ?? unknownText,
                      textScaleFactor: 1.0,
                    ),
                    dense: true,
                    tileColor: kBlueGrayColor,
                    focusColor: kPurpColor,
                    leading: const Icon(Icons.phone_android),
                    trailing: Text(i.value ?? unknownText),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class AddressesTile extends StatelessWidget {
  const AddressesTile(this._addresses, {Key? key}) : super(key: key);

  final Iterable<PostalAddress> _addresses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listTileForDetailPerson(addressesText, ""),
        Column(
          children: _addresses
              .map((a) => Padding(
                    padding: smallEdgePadding(context),
                    child: Column(
                      children: [
                        _listTileForDetail(
                            a.street, streetText, Icons.my_location_outlined),
                        _listTileForDetail(
                            a.postcode, postcodeText, Icons.local_post_office),
                        _listTileForDetail(
                            a.city, cityText, Icons.location_city),
                        _listTileForDetail(a.region, regionText,
                            Icons.real_estate_agent_outlined),
                        _listTileForDetail(
                            a.country, countryText, Icons.art_track_rounded),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _listTileForDetail(
      String? postAdress, String data, IconData iconData) {
    return Card(
      child: ListTile(
        title: Text(data),
        trailing: Text(postAdress ?? unknownText),
        dense: true,
        leading: Icon(iconData),
        tileColor: kBlueGrayColor,
      ),
    );
  }
}
