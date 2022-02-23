//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  bool _mode = false;
  String _labo = "";
  String _token = "";
  String _nombre = "";
  String _idUser = "";
  String _date = "";
  List<String> exams = [];

  int _index = 0;
  double suma =0;

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

  String get nombre {
    return _nombre;
  }

  int get index {
    return _index;
  }

  String get labo {
    return _labo;
  }

  List<String> get examns {
    return exams;
  }

  double get sum {
    return suma;
  }

  String get idUser {
    return _idUser;
  }
  String get date {
    return _date;
  }

  set token(String newToken) {
    updateToken(newToken);
    _token = newToken;
    notifyListeners();
  }
  
  set labo(String newLabo) {
    updateLabo(newLabo);
    _labo = newLabo;
    notifyListeners();
  }

  set nombre(String newNombre) {
    updateNombre(newNombre);
    _nombre = newNombre;
    notifyListeners();
  }
  set idUser(String newid) {
    updateidUser(newid);
    _idUser = newid;
    notifyListeners();
  }
  set date(String newdate) {
    updateDate(newdate);
    _date = newdate;
    notifyListeners();
  }
  set examns(List<String> newExam) {
    updateExam(newExam);
    exams = newExam;
    notifyListeners();
  }
  set addexamns(String newExam) {
    exams.add(newExam);
    updateExam(exams);
    notifyListeners();
  }
  set removeexamns(String newExam) {
    exams.remove(newExam);
    updateExam(exams);
    notifyListeners();
  }
  set sum(double newsum) {
    suma += newsum;
    updateSum(suma);
    notifyListeners();
  }
  set res(double newsum) {
    suma -= newsum;
    updateSum(suma);
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
      _nombre = prefs.getString("nombre") ?? "";
      _idUser = prefs.getString("idUser") ?? "";
      exams = prefs.getStringList("exam") ?? [];
      suma = prefs.getDouble("sum")?? 0;
      _date = prefs.getString("date") ?? "";
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
  Future<void> updateExam(List<String> exam) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("exam", exam);
  }
  Future<void> updateSum(double sum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("sum", sum);
  }

  Future<void> updateNombre(String nombre) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("nombre", nombre);
  }
  Future<void> updateidUser(String idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("idUser", idUser);
  }
  Future<void> updateDate(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("date", date);
  }
}
