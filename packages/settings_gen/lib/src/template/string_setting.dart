import 'setting_impl.dart';

class StringSettingTemplate implements SettingsImpl {
  String defaultValue;
  String name;
  bool isPrivate;

  @override
  String preInit() {
    return "_${name}Controller.add('$defaultValue');";
  }

  @override
  String postInit() {
    return "_${name}Controller.add($name);";
  }

  @override
  String dispose() {
    return ' _${name}Controller.close();';
  }

  @override
  String toString() => """
  final _${name}Controller = StreamController<String>.broadcast();
  Stream<String> get ${name}Stream => _${name}Controller.stream;

  @override
  String get $name {
    return prefs.getString('$name') ?? '$defaultValue';
  }

  @override
  set $name(String value) {
    ${name}Async(value);
  }

  Future<bool> ${name}Async(String value) async {
     final success = await prefs.setString('$name', value);
     if (success) {
        _${name}Controller.add(value);
     }
     return success;
  }
  """;
}
