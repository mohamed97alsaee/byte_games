import 'package:shared_preferences/shared_preferences.dart';

storeStringToPres(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> getStringToPres(
  String key,
) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
