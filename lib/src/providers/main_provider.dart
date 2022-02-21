import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  bool _mode = false;
  String _labo = "";
  String _token = "";
  int _index = 0;

  bool get mode {
    return _mode;
  }
  
  set mode(bool value) {
    _mode = value;
    notifyListeners();
  }

  String get token {
    return _token;
  }

  int get index {
    return _index;
  }
  
  set token(String newToken) {
    updateToken(newToken);
    _token = newToken;
    notifyListeners();
  }

  String get labo {
    return _labo;
  }
  
  set labo(String newLabo) {
    updateLabo(newLabo);
    _labo = newLabo;
    notifyListeners();
  }

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  Future<bool> getPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _mode = prefs.getBool("mode") ?? true;
      _token = prefs.getString("token") ?? "";
      _labo = prefs.getString("labo") ?? "";
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<void> updateLabo(String labo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("labo", labo);
  }
}
