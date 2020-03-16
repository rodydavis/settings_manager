import 'setting_impl.dart';

class BoolSettingTemplate implements SettingsImpl {
  bool defaultValue;
  String name;
  bool isPrivate;
  bool addStream = true;
  bool addValueNotifer = true;

  @override
  String preInit() {
    return '${name}Notify($defaultValue);';
  }

  @override
  String postInit() {
    return '${name}Notify($name);';
  }

  @override
  String dispose() {
    final sb = StringBuffer();
    if (addStream) {
      sb.writeln(' _${name}Controller.close();');
    }
    return sb.toString();
  }

  @override
  String toString() {
    final sb = StringBuffer();
    if (addStream) {
      sb.writeln(
          'final _${name}Controller = StreamController<bool>.broadcast();');
      sb.writeln(
          'Stream<bool> get ${name}Stream => _${name}Controller.stream;');
    }
    if (addValueNotifer) {
      sb.writeln('final ${name}Notifier = ValueNotifier<bool>(null);');
    }

    sb.writeln("""
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
          ${name}Notify(value);
      }
      return success;
    }
""");

    sb.writeln('void ${name}Notify(bool value) {');
    if (addStream) {
      sb.writeln(' _${name}Controller.add(value);');
    }
    if (addValueNotifer) {
      sb.writeln('${name}Notifier.value = value;');
    }
    sb.writeln('_controller.add(this);');
    sb.writeln('}');

    return sb.toString();
  }
}
