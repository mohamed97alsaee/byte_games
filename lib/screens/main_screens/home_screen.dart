import 'dart:async';

import 'package:byte_games/widgets/drawer_list_tile.dart';

import '../../helpers/notifications_helper.dart';
import '../../main.dart';
import 'package:byte_games/providers/games_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/dark_mode_provider.dart';
import '../../widgets/game_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false).fetchGames();
    // Timer(const Duration(seconds: 10), () {
    //   showNotification("hello", "hello sloma");
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesProvider>(builder: (context, gamesConsumer, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            
              showNotification("hello", "hello sloma");
            },
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text("Langs"),
                    collapsedIconColor: Colors.grey,
                    iconColor: Colors.grey,
                    textColor: Colors.orange,
                    collapsedTextColor: Colors.grey,
                    children: [
                      DrawerListTile(
                          icon: Icons.translate,
                          title: 'Spanish',
                          onPress: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const MyApp(
                                          locale: Locale('es'),
                                        )),
                                (route) => false);
                          }),
                      DrawerListTile(
                          icon: Icons.translate,
                          title: "English",
                          onPress: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const MyApp(
                                          locale: Locale('en'),
                                        )),
                                (route) => false);
                          }),
                      DrawerListTile(
                          icon: Icons.translate,
                          title: "Arabic",
                          onPress: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const MyApp(
                                          locale: Locale('ar'),
                                        )),
                                (route) => false);
                          }),
                    ],
                  ),
                  Consumer<DarkModeProvider>(builder: (context, dmc, child) {
                    return DrawerListTile(
                        icon: dmc.isDark ? Icons.light_mode : Icons.dark_mode,
                        title: dmc.isDark ? "Light Mode" : 'Dark Mode',
                        onPress: () {
                          Provider.of<DarkModeProvider>(context, listen: false)
                              .switchMode();
                        });
                  }),
                  DrawerListTile(
                      icon: Icons.exit_to_app,
                      title: 'Logout',
                      onPress: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear().then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const ScreenRouter()),
                              (route) => false);
                        });
                      }),
                ],
              ),
            ),
          ),
          appBar: AppBar(
              title: Text(
            AppLocalizations.of(context)!.hello,
          )),
          body: gamesConsumer.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: gamesConsumer.games.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.6),
                  itemBuilder: (context, index) {
                    return GameCard(
                      gameModel: gamesConsumer.games[index],
                    );
                  }));
    });
  }
}
