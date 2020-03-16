import 'package:settings_gen/src/template/comma_list.dart';
import 'package:settings_gen/src/template/bool_setting.dart';
import 'package:settings_gen/src/template/params.dart';
import 'package:settings_gen/src/template/rows.dart';

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
  final List<String> toStringList = [];

  bool generateToString = false;
  String _actionControllerName;
  String get actionControllerName =>
      _actionControllerName ??= '_\$${parentTypeName}ActionController';

  String get storeBody {
    var toStringMethod = '';

    final sb = StringBuffer();

    sb.writeln('SharedPreferences prefs;');
    sb.writeln();
    final _boolSettings = boolSettings.templates
        .whereType<BoolSettingTemplate>()
        .map((t) => t)
        .toList();

    sb.writeln(' Future<bool> init() async {');
    for (final boolSetting in _boolSettings) {
      sb.writeln(boolSetting.preInit());
    }
    sb.writeln(' prefs = await SharedPreferences.getInstance();');
    for (final boolSetting in _boolSettings) {
      sb.writeln(boolSetting.postInit());
    }
    sb.writeln(' return prefs != null;');
    sb.writeln('  }');
    sb.writeln();
    sb.writeln('$boolSettings');
    sb.writeln();
    sb.writeln(' void dispose() {');
    for (final boolSetting in _boolSettings) {
      sb.writeln(boolSetting.dispose());
    }
    sb.writeln('  }');
    sb.writeln();

    final baseBody = sb.toString();

    if (generateToString) {
      final publicBoolSettings = boolSettings.templates
        ..removeWhere((element) => element.isPrivate);

      toStringList
        ..addAll(publicBoolSettings.map(
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
