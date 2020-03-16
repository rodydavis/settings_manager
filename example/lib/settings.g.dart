// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Settings on SettingsBase, SettingsStore {
  SharedPreferences prefs;

  Future<bool> init() async {
    _darkModeController.add(false);
    prefs = await SharedPreferences.getInstance();
    _darkModeController.add(darkMode);
    return prefs != null;
  }

  final _darkModeController = StreamController<bool>.broadcast();
  Stream<bool> get darkModeStream => _darkModeController.stream;

  @override
  bool get darkMode {
    return prefs.getBool('darkMode') ?? false;
  }

  @override
  set darkMode(bool value) {
    updatedarkMode(value);
  }

  Future<bool> updatedarkMode(bool value) async {
    final sucess = await prefs.setBool('darkMode', value);
    if (sucess) {
      _darkModeController.add(value);
    }
    return sucess;
  }

  void closedarkMode() {
    _darkModeController.close();
  }

  void dispose() {
    closedarkMode();
  }

  @override
  String toString() {
    final string = 'darkMode: ${darkMode.toString()}';
    return '{$string}';
  }
}
