import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  bool isDark = false;

  switchMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = !isDark;
    prefs.setBool('isDark', isDark);
    notifyListeners();
  }

  initDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? mode = prefs.getBool('isDark');

    if (mode != null) {
      isDark = mode;
    } else {
      isDark = false;
    }
    notifyListeners();
  }
}
