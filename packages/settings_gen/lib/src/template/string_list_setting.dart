import 'setting_impl.dart';

class StringListSettingTemplate implements SettingsImpl {
  List<String> defaultValue;
  String name;
  bool isPrivate;
  bool addStream = true;
  bool addValueNotifer = true;

  @override
  String preInit() {
    return "${name}Notify($defaultValue);";
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
          'final _${name}Controller = StreamController<List<String>>.broadcast();');
      sb.writeln(
          'Stream<List<String>> get ${name}Stream => _${name}Controller.stream;');
    }
    if (addValueNotifer) {
      sb.writeln('final ${name}Notifier = ValueNotifier<List<String>>(null);');
    }

    sb.writeln("""
    
    @override
    List<String> get $name {
      return prefs.getStringList('$name') ?? $defaultValue;
    }

    @override
    set $name(List<String> value) {
      ${name}Async(value);
    }

    Future<bool> ${name}Async(List<String> value) async {
      final success = await prefs.setStringList('$name', value);
      if (success) {
          ${name}Notify(value);
      }
      return success;
    }

""");

    sb.writeln('void ${name}Notify(List<String> value) {');
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
