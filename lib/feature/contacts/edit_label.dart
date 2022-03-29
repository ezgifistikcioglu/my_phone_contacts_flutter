import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EditLabelPage extends StatefulWidget {
  final String label;

  const EditLabelPage({Key? key, required this.label}) : super(key: key);

  @override
  _EditLabelPageState createState() => _EditLabelPageState();
}

class _EditLabelPageState extends State<EditLabelPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.label);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: const Text('Edit Label'),
      content: Column(
        children: [
          PlatformTextField(
            controller: _controller,
          ),
        ],
      ),
      actions: [
        PlatformDialogAction(
            onPressed: () {
              Navigator.pop(context, _controller.text);
            },
            child: const Text('Save')),
        PlatformDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
