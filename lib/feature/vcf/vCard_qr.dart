import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VCardView extends StatefulWidget {
  final card;

  const VCardView({this.card});

  @override
  _VCardViewState createState() => _VCardViewState();
}

class _VCardViewState extends State<VCardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("vCard QR Code"),
        centerTitle: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 60,
        shadowColor: Colors.purple,
        backgroundColor: Colors.purple,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple,
              backgroundImage: NetworkImage(
                  "https://www.crushpixel.com/big-static18/preview4/identification-card-icon-id-profile-3019324.jpg"),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: QrImage(
              data: widget.card,
              size: 250.0,
              foregroundColor: Colors.purple,
              gapless: false,
              version: QrVersions.auto,
              embeddedImage: const NetworkImage(
                  "https://www.crushpixel.com/big-static18/preview4/identification-card-icon-id-profile-3019324.jpg"),
            ),
          ),
        ],
      ),
    );
  }
}
