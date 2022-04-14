import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'crud/edit_label.dart';

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
        ListTile(title: Text(widget._title)),
        Column(
          children: widget._items
              .map(
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    title: Text(i.label ?? ''),
                    trailing: Text(i.value ?? ''),
                    onTap: () async {
                      /// Pop something to edit label
                      final newLabel = await showPlatformDialog<String>(
                          context: context,
                          builder: (context) {
                            return EditLabelPage(label: i.label ?? 'No Label');
                          });

                      setState(() {
                        i.label = newLabel;
                      });
                      widget.onChange.call();
                    },
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
      children: <Widget>[
        const ListTile(title: Text('Addresses')),
        Column(
          children: _addresses
              .map((a) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Street'),
                          trailing: Text(a.street ?? ''),
                        ),
                        ListTile(
                          title: const Text('Postcode'),
                          trailing: Text(a.postcode ?? ''),
                        ),
                        ListTile(
                          title: const Text('City'),
                          trailing: Text(a.city ?? ''),
                        ),
                        ListTile(
                          title: const Text('Region'),
                          trailing: Text(a.region ?? ''),
                        ),
                        ListTile(
                          title: const Text('Country'),
                          trailing: Text(a.country ?? ''),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
