import 'dart:convert';

import 'package:byte_games/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import '../widgets/game_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GameModel> games = [];
  fetchGames() async {
    var response =
        await http.get(Uri.parse('https://www.freetogame.com/api/games'));

    if (response.statusCode == 200) {
      print('✅🫡');
      var decodedData = json.decode(response.body);

      for (var item in decodedData) {
        games.add(GameModel.fromJson(item));
      }
      setState(() {});
    } else {
      print("❌");
    }
  }

  @override
  void initState() {
    fetchGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.6),
            itemBuilder: (context, index) {
              return GameCard(
                gameModel: games[index],
              );
            }));
  }
}
