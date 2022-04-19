import 'package:flutter/material.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/share_button_widget.dart';
import 'package:my_phone_contacts/feature/contacts/share/widget/textfield_widget.dart';
import 'package:my_phone_contacts/utils/utils.dart';
import 'package:share_plus/share_plus.dart';

class ShareFilesWidget extends StatefulWidget {
  const ShareFilesWidget({Key? key}) : super(key: key);

  @override
  _ShareFilesWidgetState createState() => _ShareFilesWidgetState();
}

class _ShareFilesWidgetState extends State<ShareFilesWidget> {
  final controller = TextEditingController();

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
              TextfieldWidget(
                controller: controller,
              ),
              const SizedBox(height: 32),
              ShareButtonWidget(
                onClicked: () async {
                  if (controller.text.isEmpty) {
                    Utils.showSnackbar(context, message: 'Enter a caption!');
                  } else if (controller.text.contains(controller.text)) {
                    Share.share(controller.text);
                  } else {
                    final filePaths = await Utils.pickFile();

                    Share.shareFiles(filePaths, text: controller.text);
                  }
                },
              ),
            ],
          ),
        ),
      );
}
