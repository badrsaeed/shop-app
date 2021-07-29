import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_shop/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const key = 'AIzaSyBuTVZHtOmRxrNOc2FgJLuJo5ckSw0hlhY';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiredDate;
  late String _userId;
  late Timer _authTimer;

  String get userId {
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _expiredDate.isAfter(DateTime.now()) &&
        _expiredDate != null) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$key";
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(res.body);
      if (responseData['error'] != null) {
        HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiredDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiredDate': _expiredDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<bool?> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;

    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedData['expiredDate'].toString());
    if(expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedData['token'].toString();
    _userId = extractedData[userId].toString();
    _expiredDate = expiryDate;

    notifyListeners();
    return true;
  }
}
