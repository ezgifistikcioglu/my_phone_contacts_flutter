import 'package:flutter/material.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/share_button_widget.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/textfield_widget.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/utils.dart';
import 'package:share_plus/share_plus.dart';

class ShareTextWidget extends StatefulWidget {
  const ShareTextWidget({Key? key}) : super(key: key);

  @override
  _ShareTextWidgetState createState() => _ShareTextWidgetState();
}

class _ShareTextWidgetState extends State<ShareTextWidget> {
  final controller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextfieldWidget(controller: controller),
              const SizedBox(height: 32),
              ShareButtonWidget(
                onClicked: () {
                  if (controller.text.isEmpty) {
                    Utils.showSnackbar(context, message: 'Enter a caption!');
                  } else {
                    Share.share(controller.text);
                  }
                },
                key: _scaffoldKey,
              ),
            ],
          ),
        ),
      );
}
