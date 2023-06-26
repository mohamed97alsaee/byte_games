import 'package:byte_games/providers/auth_provider.dart';
import 'package:byte_games/providers/games_provider.dart';
import 'package:byte_games/screens/auth_screens/splash_screen.dart';
import 'package:byte_games/screens/handling_screens/loading_screen.dart';
import 'package:byte_games/screens/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
