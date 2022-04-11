import 'package:flutter/material.dart';
import 'package:my_phone_contacts/core/constants/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_phone_contacts/feature/contacts/crud/person_details_page.dart';

import 'package:provider/provider.dart';
import 'feature/contacts/crud/read_contacts.dart';
import 'feature/language/language_manager.dart';
import 'providers/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    ChangeNotifierProvider<LanguageProvider>(
      create: (context) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Değişimini dinleyeceğimiz değişkene erişim için
    final watch = context.watch<LanguageProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: LanguageManager.instance.localizationsDelegates,
      supportedLocales: LanguageManager.instance.supportedLocales,

      /// Uygulamanın başlatılacağı dil
      locale: watch.locale,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Home(),
    );
  }
}
