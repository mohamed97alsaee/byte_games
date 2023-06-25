import 'dart:convert';

import 'package:byte_games/models/detailed_game_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailedGameScreen extends StatefulWidget {
  const DetailedGameScreen({super.key, required this.gameId});
  final String gameId;
  @override
  State<DetailedGameScreen> createState() => _DetailedGameScreenState();
}

class _DetailedGameScreenState extends State<DetailedGameScreen> {
  bool isLoading = false;
  DetailedGameModel? detailedGameModel;

  fetchSingleGame(String gId) async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://www.freetogame.com/api/game?id=$gId'));

    if (response.statusCode == 200) {
      setState(() {
        detailedGameModel =
            DetailedGameModel.fromJson(json.decode(response.body));
      });
    } else {
      if (kDebugMode) {
        print('FAILED REQUEST');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchSingleGame(widget.gameId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Text(widget.gameId),
                  Image.network(detailedGameModel!.thumbnail,
                      errorBuilder: (context, error, stackTrace) {
                    return const CircularProgressIndicator();
                  }),
                ],
              ),
      ),
    );
  }
}
