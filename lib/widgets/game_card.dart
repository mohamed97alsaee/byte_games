import 'package:byte_games/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GameCard extends StatefulWidget {
  const GameCard({super.key, required this.gameModel});
  final GameModel gameModel;
  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            footer: Container(
                height: 100,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.gameModel.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        widget.gameModel.publisher,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                      )
                    ],
                  ),
                )),
            header: Container(
                height: 60,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.gameModel.genre,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                      )
                    ],
                  ),
                )),
            child: Container(
                child: Image.network(
              widget.gameModel.thumbnail,
              fit: BoxFit.cover,
            ))),
      ),
    );
    ;
  }
}
