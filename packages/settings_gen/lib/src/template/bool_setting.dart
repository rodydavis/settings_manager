class BoolSettingTemplate {
  bool defaultValue;
  String name;
  bool isPrivate;

  String preInit() {
    return '_${name}Controller.add($defaultValue);';
  }

  String postInit() {
    return '_${name}Controller.add($name);';
  }

  String dispose() {
    return ' _${name}Controller.close();';
  }

  @override
  String toString() => """
  final _${name}Controller = StreamController<bool>.broadcast();
  Stream<bool> get ${name}Stream => _${name}Controller.stream;

  @override
  bool get $name {
    return prefs.getBool('$name') ?? $defaultValue;
  }

  @override
  set $name(bool value) {
    ${name}Async(value);
  }

  Future<bool> ${name}Async(bool value) async {
     final success = await prefs.setBool('$name', value);
     if (success) {
        _${name}Controller.add(value);
     }
     return success;
  }
  """;
}
