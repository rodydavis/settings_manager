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
    return 'close${name}();';
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
    update$name(value);
  }

  Future<bool> update$name(bool value) async {
     final sucess = await prefs.setBool('$name', value);
     if (sucess) {
        _${name}Controller.add(value);
     }
     return sucess;
  }

  void close${name}() {
    _${name}Controller.close();
  }
  """;
}
