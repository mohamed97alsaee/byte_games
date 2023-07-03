import 'package:byte_games/providers/auth_provider.dart';
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
  runApp(const MyApp());
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
    getLocaleLang().then((value) {
      if (kDebugMode) {
        print("LOCALE IS : ${_locale!.languageCode.toString()}");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GamesProvider>(
            create: (context) => GamesProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider())
      ],
      child: MaterialApp(
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
            primarySwatch: Colors.orange,
            textTheme: GoogleFonts.milongaTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const ScreenRouter()),
    );
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
