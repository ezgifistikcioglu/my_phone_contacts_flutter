import 'package:flutter/material.dart';
import 'package:my_phone_contacts/feature/language/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import 'item_dialog.dart';

class ChangeLanguageDialog extends StatelessWidget {
  const ChangeLanguageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Yeni değer ataması yapacağımız metota erişim için
    final read = context.read<LanguageProvider>();

    /// 2. Alternatif
    /// final read= Provider.of<LanguageProvider>(context, listen: false);
    /// [listen: false]: Rebuild olmaması için
    return SimpleDialog(
      title: Text(
        context.translate('phone_language'),
      ),
      children: [
        /// Bu ItemDialog'u da ayrı bir StatelessWidget olarak tasarlayacağız
        ItemDialog(
          path: 'en_US_language_icon.png',
          text: context.translate('english'),
          onPressed: () {
            /// Yeni değer olarak Amerikan İngilizcesi'ni atıyoruz
            read.setLocale = const Locale('en', 'US');

            /// Future.delayed - Bekletme metodu ile 1 saniye bekletiyoruz
            Future.delayed(
              const Duration(
                seconds: 1,
              ),
            );

            /// Ekranı kapatıp, önceki sayfaya dönüyoruz.
            Navigator.pop(context);
          },
        ),
        ItemDialog(
          path: 'tr_TR_language_icon.png',
          text: context.translate('turkish'),
          onPressed: () {
            read.setLocale = const Locale('tr', 'TR');
            Future.delayed(
              const Duration(
                seconds: 1,
              ),
            );
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
