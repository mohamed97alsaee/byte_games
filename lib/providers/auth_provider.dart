import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AuthProvider with ChangeNotifier {
  Api api = Api();
  String? token;
  Status userStatus = Status.uninitialized;

  bool isLoading = false;
  setloading(bool status) {
    isLoading = status;
    notifyListeners();
  }

  initAuthProvider() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    if (kDebugMode) {
      print("TOKEN IS : $token");
    }
    if (token != null) {
      userStatus = Status.authenticated;
    } else {
      userStatus = Status.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(Map body) async {
    setloading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await api.post('https://api.ha-k.ly/api/v1/client/auth/login', body);

    if (response.statusCode == 201) {
      var decodedData = json.decode(response.body);

      prefs.setString('token', decodedData['token']);
      userStatus = Status.authenticated;
      setloading(false);

      return true;
    } else {
      prefs.clear();
      userStatus = Status.unauthenticated;
      setloading(false);

      return false;
    }
  }
}
