import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/app_constants.dart';
import 'package:my_phone_contacts/feature/vcf/vCard_qr.dart';

class VcfFilesWidget extends StatefulWidget {
  const VcfFilesWidget({Key? key}) : super(key: key);

  @override
  _VcfFilesWidgetState createState() => _VcfFilesWidgetState();
}

class _VcfFilesWidgetState extends State<VcfFilesWidget> {
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController org = TextEditingController();
  TextEditingController title = TextEditingController();

  void nav() {
    String qr_name = name.text;
    String qr_contact = contact.text;
    String qr_work = work.text;
    String qr_mail = mail.text;
    String qr_org = org.text;
    String qr_title = title.text;

    String card =
        "BEGIN:VCARD \nN:$qr_name; \nTEL;TYPE=mobile,VOICE:$qr_contact \nTEL;TYPE=work,VOICE:$qr_work \nEMAIL:$qr_mail \nORG:$qr_org \nTITLE:$qr_title \nVERSION:3.0 \nEND:VCARD";
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VCardView(
                card: card,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
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
            height: 30,
          ),
          Container(
            padding: smallEdgePadding(context),
            child: TextField(
              cursorColor: Colors.purple,
              controller: name,
              style: const TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.account_box_outlined, color: Colors.purple),
                labelText: "Name",
                labelStyle: const TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.purple,
                        width: 3.0),
                    borderRadius: BorderRadius.circular(50)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: smallEdgePadding(context),
            child: TextField(
              cursorColor: Colors.purple,
              controller: contact,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.contacts_outlined, color: Colors.purple),
                labelText: "Contact Number",
                labelStyle: const TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.purple,
                        width: 3.0),
                    borderRadius: BorderRadius.circular(50)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: smallEdgePadding(context),
            child: TextField(
              controller: work,
              keyboardType: TextInputType.number,
              cursorColor: Colors.purple,
              style: const TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.contacts_outlined, color: Colors.purple),
                labelText: "Work Contact Number",
                labelStyle: const TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.purple,
                        width: 3.0),
                    borderRadius: BorderRadius.circular(50)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: smallEdgePadding(context),
            child: TextField(
              cursorColor: Colors.purple,
              controller: mail,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail_outline_outlined,
                    color: Colors.purple),
                labelText: "E-Mail",
                labelStyle: const TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.purple,
                        width: 3.0),
                    borderRadius: BorderRadius.circular(50)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: smallEdgePadding(context),
            child: TextField(
              cursorColor: Colors.purple,
              controller: org,
              style: const TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.home, color: Colors.purple),
                labelText: "Organisation",
                labelStyle: const TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.purple,
                        width: 3.0),
                    borderRadius: BorderRadius.circular(50)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: smallEdgePadding(context),
            child: TextField(
              cursorColor: Colors.purple,
              controller: title,
              style: const TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.title_outlined, color: Colors.purple),
                labelText: "Job Title",
                labelStyle: const TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.purple,
                        width: 3.0),
                    borderRadius: BorderRadius.circular(50)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton.icon(
            onPressed: () {
              nav();
            },
            icon: const Icon(
              Icons.qr_code_rounded,
              color: Colors.white,
            ),
            label: const Text(
              "Generate",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                name.text = "";
                contact.text = "";
                work.text = "";
                mail.text = "";
                org.text = "";
                title.text = "";
              });
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
            label: const Text(
              "Clear Fields",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
