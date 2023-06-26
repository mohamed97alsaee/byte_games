import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<http.Response> get(
    String url,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    http.Response response = await http.get(Uri.parse(url), headers: {
      if (token != null) "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "application/json"
    });

    if (kDebugMode) {
      print('GET ON : $url');
      print('GET STATUS CODE : ${response.statusCode}');
      print('GET RESPONSE BODY : ${json.decode(response.body)}');
    }

    return response;
  }

  Future<http.Response> post(String url, Map body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    http.Response response =
        await http.post(Uri.parse(url), body: json.encode(body), headers: {
      if (token != null) "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    if (kDebugMode) {
      print('POST REQUEST BODY $body');
      print('POST ON : $url');
      print('POST STATUS CODE : ${response.statusCode}');
      print('POST RESPONSE BODY : ${json.decode(response.body)}');
    }

    return response;
  }

  Future<http.Response> put(String url, Map body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    http.Response response =
        await http.put(Uri.parse(url), body: json.encode(body), headers: {
      if (token != null) "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    if (kDebugMode) {
      print('PUT REQUEST BODY $body');
      print('PUT ON : $url');
      print('PUT STATUS CODE : ${response.statusCode}');
      print('PUT RESPONSE BODY : ${json.decode(response.body)}');
    }

    return response;
  }

  Future<http.Response> delete(String url, Map body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    http.Response response = await http.delete(Uri.parse(url), headers: {
      if (token != null) "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
    if (kDebugMode) {
      print('DELETE ON : $url');
      print('DELETE STATUS CODE : ${response.statusCode}');
      print('DELETE RESPONSE BODY : ${json.decode(response.body)}');
    }

    return response;
  }
}
