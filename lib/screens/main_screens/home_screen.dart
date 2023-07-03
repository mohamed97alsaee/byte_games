import '../../main.dart';
import 'package:byte_games/providers/games_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesProvider>(builder: (context, gamesConsumer, child) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
            AppLocalizations.of(context)!.hello,
          )),
          floatingActionButton: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    child: const Text("EN"),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MyApp(
                                    locale: Locale('en'),
                                  )),
                          (route) => false);
                    }),
                FloatingActionButton(
                    child: const Text("ES"),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MyApp(
                                    locale: Locale('es'),
                                  )),
                          (route) => false);
                    }),
                FloatingActionButton(
                    child: const Text("AR"),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MyApp(
                                    locale: Locale('ar'),
                                  )),
                          (route) => false);
                    }),
                FloatingActionButton(onPressed: () async {
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
