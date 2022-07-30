import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/res/palette.dart';
import 'app_translations.dart';
import 'initial_bindings.dart';
import 'routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Medplus',
      // textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      translations: AppTranslations.get(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale.fromSubtags(
        languageCode: 'en',
        countryCode: 'US',
      ),

      theme: lightTheme,
      themeMode: ThemeMode.light,
      getPages: Routes.get(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? Container(),
        );
      },
      defaultTransition: Transition.rightToLeft,
      initialRoute: Routes.initialRoute,
    );
  }
}

ThemeData get lightTheme => ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        // cursorColor: Palette.textColor,
        selectionColor: Palette.primaryColor.withOpacity(0.5),
        selectionHandleColor: Palette.primaryColor.withOpacity(0.5),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Palette.primaryColor,
      // canvasColor: Colors.transparent,
      // splashColor: const Color(0xffefeff5),
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: Colors.white,
    );
