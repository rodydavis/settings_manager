import 'setting_impl.dart';

class IntSettingTemplate implements SettingsImpl {
  int defaultValue;
  String name;
  bool isPrivate;
  bool addStream = true;
  bool addValueNotifier = true;

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
          'final _${name}Controller = StreamController<int>.broadcast();');
      sb.writeln('Stream<int> get ${name}Stream => _${name}Controller.stream;');
    }
    if (addValueNotifier) {
      sb.writeln('final _${name}Notifier = ValueNotifier<int>($defaultValue);');
      sb.writeln('ValueListenable<int> get ${name}Notifier => _${name}Notifier;');
    }

    sb.writeln("""

    @override
    int get $name {
      return prefs?.getInt('$name') ?? $defaultValue;
    }

    @override
    set $name(int value) {
      ${name}Async(value);
    }

    Future<bool> ${name}Async(int value) async {
      final success = await prefs.setInt('$name', value);
      if (success) {
          ${name}Notify(value);
      }
      return success;
    }

""");

    sb.writeln('void ${name}Notify(int value) {');
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
