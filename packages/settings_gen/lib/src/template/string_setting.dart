import 'setting_impl.dart';

class StringSettingTemplate implements SettingsImpl {
  String defaultValue;
  String name;
  bool isPrivate;
  bool addStream = true;
  bool addValueNotifier = true;

  @override
  String preInit() {
    return "${name}Notify('$defaultValue');";
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
          'final _${name}Controller = StreamController<String>.broadcast();');
      sb.writeln(
          'Stream<String> get ${name}Stream => _${name}Controller.stream;');
    }
    if (addValueNotifier) {
      sb.writeln("final _${name}Notifier = ValueNotifier<String>('$defaultValue');");
      sb.writeln('ValueListenable<String> get ${name}Notifier => _${name}Notifier;');
    }

    sb.writeln("""

    @override
    String get $name {
      return prefs?.getString('$name') ?? '$defaultValue';
    }

    @override
    set $name(String value) {
      ${name}Async(value);
    }

    Future<bool> ${name}Async(String value) async {
      final success = await prefs.setString('$name', value);
      if (success) {
          ${name}Notify(value);
      }
      return success;
    }

""");

    sb.writeln('void ${name}Notify(String value) {');
    if (addStream) {
      sb.writeln(' _${name}Controller.add(value);');
    }
    if (addValueNotifier) {
      sb.writeln('_${name}Notifier.value = value;');
    }
    sb.writeln('_controller.add(this);');
    sb.writeln('}');

    return sb.toString();
  }
}
