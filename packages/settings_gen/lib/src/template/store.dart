import 'bool_setting.dart';
import 'comma_list.dart';
import 'double_setting.dart';
import 'int_setting.dart';
import 'params.dart';
import 'rows.dart';
import 'setting_impl.dart';
import 'string_list_setting.dart';
import 'string_setting.dart';

class MixinStoreTemplate extends StoreTemplate {
  String get typeName => '_\$$publicTypeName';

  @override
  String toString() => '''

  mixin $typeName$typeParams on $parentTypeName$typeArgs, SettingsStore {
    $storeBody
  }''';
}

abstract class StoreTemplate {
  final SurroundedCommaList<TypeParamTemplate> typeParams =
      SurroundedCommaList('<', '>', []);
  final SurroundedCommaList<String> typeArgs =
      SurroundedCommaList('<', '>', []);
  String publicTypeName;
  String parentTypeName;

  final Rows<BoolSettingTemplate> boolSettings = Rows();
  final Rows<StringSettingTemplate> stringSettings = Rows();
  final Rows<IntSettingTemplate> intSettings = Rows();
  final Rows<DoubleSettingTemplate> doubleSettings = Rows();
  final Rows<StringListSettingTemplate> stringListSettings = Rows();
  final List<String> toStringList = [];

  bool generateToString = false;
  String _actionControllerName;
  String get actionControllerName =>
      _actionControllerName ??= '_\$${parentTypeName}ActionController';

  String get storeBody {
    var toStringMethod = '';

    final sb = StringBuffer();

    sb.writeln('SharedPreferences prefs;');
    sb.writeln(
        'final _controller = StreamController<$publicTypeName>.broadcast();');
    sb.writeln('Stream<$publicTypeName> get stream => _controller.stream;');
    sb.writeln();
    List<SettingsImpl> _settingsImpl = [];
    _settingsImpl.addAll(
      boolSettings.templates.whereType<SettingsImpl>().map((t) => t).toList(),
    );
    _settingsImpl.addAll(
      stringSettings.templates.whereType<SettingsImpl>().map((t) => t).toList(),
    );
    _settingsImpl.addAll(
      intSettings.templates.whereType<SettingsImpl>().map((t) => t).toList(),
    );
    _settingsImpl.addAll(
      doubleSettings.templates.whereType<SettingsImpl>().map((t) => t).toList(),
    );
    _settingsImpl.addAll(
      stringListSettings.templates
          .whereType<SettingsImpl>()
          .map((t) => t)
          .toList(),
    );
    sb.writeln(' Future<bool> init() async {');
    for (final setting in _settingsImpl) {
      sb.writeln(setting.preInit());
    }
    sb.writeln(' prefs = await SharedPreferences.getInstance();');
    for (final setting in _settingsImpl) {
      sb.writeln(setting.postInit());
    }
    sb.writeln(' return prefs != null;');
    sb.writeln('  }');
    sb.writeln();
    sb.writeln('$boolSettings');
    sb.writeln();
    sb.writeln('$stringSettings');
    sb.writeln();
    sb.writeln('$intSettings');
    sb.writeln();
    sb.writeln('$doubleSettings');
    sb.writeln();
    sb.writeln('$stringListSettings');
    sb.writeln();
    sb.writeln(' void dispose() {');
    for (final setting in _settingsImpl) {
      sb.writeln(setting.dispose());
    }
    sb.writeln('_controller.close();');
    sb.writeln('  }');
    sb.writeln();

    final baseBody = sb.toString();

    if (generateToString) {
      final publicBoolSettings = boolSettings.templates
        ..removeWhere((element) => element.isPrivate);
      final publicStringSettings = stringSettings.templates
        ..removeWhere((element) => element.isPrivate);
      final publicIntSettings = intSettings.templates
        ..removeWhere((element) => element.isPrivate);
      final publicDoubleSettings = doubleSettings.templates
        ..removeWhere((element) => element.isPrivate);
      final publicStringListSettings = doubleSettings.templates
        ..removeWhere((element) => element.isPrivate);

      toStringList
        ..addAll(publicBoolSettings.map(
            (current) => '${current.name}: \${${current.name}.toString()}'))
        ..addAll(publicStringSettings.map(
            (current) => '${current.name}: \${${current.name}.toString()}'))
        ..addAll(publicIntSettings.map(
            (current) => '${current.name}: \${${current.name}.toString()}'))
        ..addAll(publicDoubleSettings.map(
            (current) => '${current.name}: \${${current.name}.toString()}'))
        ..addAll(publicStringListSettings.map(
            (current) => '${current.name}: \${${current.name}.toString()}'));

      toStringMethod = '''
  @override
  String toString() {
    final string = \'${toStringList.join(',')}\';
    return '{\$string}';
  }
  ''';
    }

    return baseBody + toStringMethod;
  }

  @override
  String toString();
}
