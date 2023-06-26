import '../models/detailed_game_model.dart';
import 'dart:convert';
import '../models/game_model.dart';
import 'package:flutter/foundation.dart';
import '../services/api.dart';

class GamesProvider with ChangeNotifier {
  //----------------- Utils ----------------- //

  Api api = Api();
  bool isLoading = false;

  setLoading(bool status) {
    isLoading = status;
    notifyListeners();
  }

  //----------------- Data ----------------- //
  List<GameModel> games = [];
  DetailedGameModel? detailedGameModel;

  //----------------- Functions ----------------- //

  fetchGames() async {
    setLoading(true);
    var response = await api.get('https://www.freetogame.com/api/games');

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('✅🫡');
      }
      var decodedData = json.decode(response.body);

      for (var item in decodedData) {
        games.add(GameModel.fromJson(item));
      }
    } else {
      if (kDebugMode) {
        print("❌");
      }
    }
    setLoading(false);
  }

  fetchSingleGame(String gId) async {
    setLoading(true);
    final response =
        await api.get('https://www.freetogame.com/api/game?id=$gId');
    if (response.statusCode == 200) {
      detailedGameModel =
          DetailedGameModel.fromJson(json.decode(response.body));
    } else {
      if (kDebugMode) {
        print('FAILED REQUEST');
      }
    }
    setLoading(false);
  }
}
