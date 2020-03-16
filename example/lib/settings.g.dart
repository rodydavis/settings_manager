// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Settings on SettingsBase, SettingsStore {
  SharedPreferences prefs;
  final _controller = StreamController<Settings>.broadcast();
  Stream<Settings> get stream => _controller.stream;

  Future<bool> init() async {
    darkModeNotify(false);
    _defaultUserIdController.add('none');
    prefs = await SharedPreferences.getInstance();
    darkModeNotify(darkMode);
    _defaultUserIdController.add(defaultUserId);
    return prefs != null;
  }

  final _darkModeController = StreamController<bool>.broadcast();
  Stream<bool> get darkModeStream => _darkModeController.stream;
  final darkModeNotifier = ValueNotifier<bool>(null);
  @override
  bool get darkMode {
    return prefs.getBool('darkMode') ?? false;
  }

  @override
  set darkMode(bool value) {
    darkModeAsync(value);
  }

  Future<bool> darkModeAsync(bool value) async {
    final success = await prefs.setBool('darkMode', value);
    if (success) {
      darkModeNotify(value);
    }
    return success;
  }

  void darkModeNotify(bool value) {
    _darkModeController.add(value);
    darkModeNotifier.value = value;
    _controller.add(this);
  }

  final _defaultUserIdController = StreamController<String>.broadcast();
  Stream<String> get defaultUserIdStream => _defaultUserIdController.stream;

  @override
  String get defaultUserId {
    return prefs.getString('defaultUserId') ?? 'none';
  }

  @override
  set defaultUserId(String value) {
    defaultUserIdAsync(value);
  }

  Future<bool> defaultUserIdAsync(String value) async {
    final success = await prefs.setString('defaultUserId', value);
    if (success) {
      _defaultUserIdController.add(value);
    }
    return success;
  }

  void dispose() {
    _darkModeController.close();

    _defaultUserIdController.close();
    _controller.close();
  }

  @override
  String toString() {
    final string = 'darkMode: ${darkMode.toString()}';
    return '{$string}';
  }
}
