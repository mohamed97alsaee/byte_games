import 'package:byte_games/helpers/notifications_helper.dart';
import 'package:byte_games/providers/auth_provider.dart';
import 'package:byte_games/providers/dark_mode_provider.dart';
import 'package:byte_games/providers/games_provider.dart';
import 'package:byte_games/screens/auth_screens/splash_screen.dart';
import 'package:byte_games/screens/handling_screens/loading_screen.dart';
import 'package:byte_games/screens/main_screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'helpers/functions_helper.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
    ChangeNotifierProvider<DarkModeProvider>(
        create: (context) => DarkModeProvider()),
    ChangeNotifierProvider<GamesProvider>(create: (context) => GamesProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.locale});
  final Locale? locale;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  getLocaleLang() async {
    if (widget.locale == null) {
      String lang = await getStringToPres('localCode') ?? 'en';
      setState(() {
        _locale = Locale(lang);
      });
    } else {
      setState(() {
        _locale = widget.locale;
      });
    }
    storeStringToPres('localCode', _locale!.languageCode.toString());
  }

  @override
  void initState() {
    Provider.of<DarkModeProvider>(context, listen: false).initDarkMode();
    getLocaleLang().then((value) {
      if (kDebugMode) {
        print("LOCALE IS : ${_locale!.languageCode.toString()}");
      }
    });

    super.initState();
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // var initializationSettingsAndroid = AndroidInitializationSettings(
    //     'app_icon'); // <- default icon name is @mipmap/ic_launcher
    // var initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // var initializationSettings = InitializationSettings(
    //     initializationSettingsAndroid, initializationSettingsIOS);

    showNotification('title', 'body');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
        builder: (context, darkModeConsumer, child) {
      return MaterialApp(
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
            Locale('es'), // spanish
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor:
                      darkModeConsumer.isDark ? Colors.white60 : Colors.black),
              iconTheme: IconThemeData(
                  color:
                      darkModeConsumer.isDark ? Colors.white60 : Colors.black),
              primaryIconTheme: IconThemeData(
                  color:
                      darkModeConsumer.isDark ? Colors.white60 : Colors.black),
              dividerTheme: DividerThemeData(
                  color:
                      darkModeConsumer.isDark ? Colors.white : Colors.black54),
              listTileTheme: ListTileThemeData(
                  titleTextStyle: TextStyle(
                      color: darkModeConsumer.isDark
                          ? Colors.white
                          : Colors.black)),
              drawerTheme: DrawerThemeData(
                  backgroundColor:
                      darkModeConsumer.isDark ? Colors.black : Colors.white),
              appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(
                      color: darkModeConsumer.isDark
                          ? Colors.white
                          : Colors.black),
                  color: darkModeConsumer.isDark ? Colors.blue : Colors.orange),
              primarySwatch: Colors.orange,
              textTheme: GoogleFonts.milongaTextTheme(
                Theme.of(context).textTheme,
              ),
              scaffoldBackgroundColor:
                  darkModeConsumer.isDark ? Colors.black : Colors.white),
          home: const ScreenRouter());
    });
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, child) {
        switch (authConsumer.userStatus) {
          case Status.uninitialized:
            return const LoadingScreen();

          case Status.authenticating:
            return const LoadingScreen();
          case Status.authenticated:
            return const HomeScreen();
          case Status.unauthenticated:
            return const SplashScreen();

          default:
            return const SplashScreen();
        }
      },
    );
  }
}
