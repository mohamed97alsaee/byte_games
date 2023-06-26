import 'package:byte_games/providers/games_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedGameScreen extends StatefulWidget {
  const DetailedGameScreen({super.key, required this.gameId});
  final String gameId;
  @override
  State<DetailedGameScreen> createState() => _DetailedGameScreenState();
}

class _DetailedGameScreenState extends State<DetailedGameScreen> {
  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false)
        .fetchSingleGame(widget.gameId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<GamesProvider>(builder: (context, gamesConsumer, child) {
      return Scaffold(
        body: Center(
          child: gamesConsumer.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
                          child: Image.network(
                              gamesConsumer.detailedGameModel!.thumbnail,
                              width: size.width,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                            return const CircularProgressIndicator();
                          }),
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: SafeArea(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                    GridView.builder(
                        itemCount:
                            gamesConsumer.detailedGameModel!.screenshots.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GridTile(
                                  child: Image.network(
                                gamesConsumer.detailedGameModel!
                                    .screenshots[index].image,
                                fit: BoxFit.cover,
                              )),
                            ),
                          );
                        })
                  ],
                ),
        ),
      );
    });
  }
}
