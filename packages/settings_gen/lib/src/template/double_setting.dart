import 'setting_impl.dart';

class DoubleSettingTemplate implements SettingsImpl {
  double defaultValue;
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
          'final _${name}Controller = StreamController<double>.broadcast();');
      sb.writeln(
          'Stream<double> get ${name}Stream => _${name}Controller.stream;');
    }
    if (addValueNotifier) {
      sb.writeln('final _${name}Notifier = ValueNotifier<double>($defaultValue);');
      sb.writeln(
          'ValueListenable<double> get ${name}Notifier => _${name}Notifier;');
    }

    sb.writeln("""

    @override
    double get $name {
      return prefs?.getDouble('$name') ?? $defaultValue;
    }

    @override
    set $name(double value) {
      ${name}Async(value);
    }

    Future<bool> ${name}Async(double value) async {
      final success = await prefs.setDouble('$name', value);
      if (success) {
          ${name}Notify(value);
      }
      return success;
    }
    
""");

    sb.writeln('void ${name}Notify(double value) {');
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
