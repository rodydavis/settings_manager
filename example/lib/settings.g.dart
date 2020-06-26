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
    userIdNotify('none');
    counterValueNotify(0);
    radialValueNotify(0.0);
    savedItemsNotify([]);
    prefs = await SharedPreferences.getInstance();
    darkModeNotify(darkMode);
    userIdNotify(userId);
    counterValueNotify(counterValue);
    radialValueNotify(radialValue);
    savedItemsNotify(savedItems);
    return prefs != null;
  }

  final _darkModeController = StreamController<bool>.broadcast();
  Stream<bool> get darkModeStream => _darkModeController.stream;
  final _darkModeNotifier = ValueNotifier<bool>(false);
  ValueListenable<bool> get darkModeNotifier => _darkModeNotifier;

  @override
  bool get darkMode {
    return prefs?.getBool('darkMode') ?? false;
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
    _darkModeNotifier.value = value;
    _controller.add(this);
  }

  final _userIdController = StreamController<String>.broadcast();
  Stream<String> get userIdStream => _userIdController.stream;
  final _userIdNotifier = ValueNotifier<String>('none');
  ValueListenable<String> get userIdNotifier => _userIdNotifier;

  @override
  String get userId {
    return prefs?.getString('userId') ?? 'none';
  }

  @override
  set userId(String value) {
    userIdAsync(value);
  }

  Future<bool> userIdAsync(String value) async {
    final success = await prefs.setString('userId', value);
    if (success) {
      userIdNotify(value);
    }
    return success;
  }

  void userIdNotify(String value) {
    _userIdController.add(value);
    _userIdNotifier.value = value;
    _controller.add(this);
  }

  final _counterValueController = StreamController<int>.broadcast();
  Stream<int> get counterValueStream => _counterValueController.stream;
  final _counterValueNotifier = ValueNotifier<int>(0);
  ValueListenable<int> get counterValueNotifier => _counterValueNotifier;

  @override
  int get counterValue {
    return prefs?.getInt('counterValue') ?? 0;
  }

  @override
  set counterValue(int value) {
    counterValueAsync(value);
  }

  Future<bool> counterValueAsync(int value) async {
    final success = await prefs.setInt('counterValue', value);
    if (success) {
      counterValueNotify(value);
    }
    return success;
  }

  void counterValueNotify(int value) {
    _counterValueController.add(value);
    _counterValueNotifier.value = value;
    _controller.add(this);
  }

  final _radialValueController = StreamController<double>.broadcast();
  Stream<double> get radialValueStream => _radialValueController.stream;
  final _radialValueNotifier = ValueNotifier<double>(0.0);
  ValueListenable<double> get radialValueNotifier => _radialValueNotifier;

  @override
  double get radialValue {
    return prefs?.getDouble('radialValue') ?? 0.0;
  }

  @override
  set radialValue(double value) {
    radialValueAsync(value);
  }

  Future<bool> radialValueAsync(double value) async {
    final success = await prefs.setDouble('radialValue', value);
    if (success) {
      radialValueNotify(value);
    }
    return success;
  }

  void radialValueNotify(double value) {
    _radialValueController.add(value);
    _radialValueNotifier.value = value;
    _controller.add(this);
  }

  final _savedItemsController = StreamController<List<String>>.broadcast();
  Stream<List<String>> get savedItemsStream => _savedItemsController.stream;
  final _savedItemsNotifier = ValueNotifier<List<String>>([]);
  ValueListenable<List<String>> get savedItemsNotifier => _savedItemsNotifier;

  @override
  List<String> get savedItems {
    return prefs?.getStringList('savedItems') ?? [];
  }

  @override
  set savedItems(List<String> value) {
    savedItemsAsync(value);
  }

  Future<bool> savedItemsAsync(List<String> value) async {
    final success = await prefs.setStringList('savedItems', value);
    if (success) {
      savedItemsNotify(value);
    }
    return success;
  }

  void savedItemsNotify(List<String> value) {
    _savedItemsController.add(value);
    _savedItemsNotifier.value = value;
    _controller.add(this);
  }

  void dispose() {
    _darkModeController.close();

    _userIdController.close();

    _counterValueController.close();

    _radialValueController.close();

    _savedItemsController.close();

    _controller.close();
  }

  @override
  String toString() {
    final string =
        'darkMode: ${darkMode.toString()},userId: ${userId.toString()},counterValue: ${counterValue.toString()},radialValue: ${radialValue.toString()},radialValue: ${radialValue.toString()}';
    return '{$string}';
  }
}
