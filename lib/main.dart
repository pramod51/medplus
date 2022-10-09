import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
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
      textDirection: SharedConfig.textDirection,
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      translations: AppTranslations.get(),
      locale: Locale(SharedConfig.locale.first, SharedConfig.locale.last),
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

class RestartWidget extends StatefulWidget {
  const RestartWidget({
    Key? key,
  }) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: const MyApp(),
    );
  }
}
