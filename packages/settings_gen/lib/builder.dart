import 'package:build/build.dart';
import 'package:settings_gen/settings_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder storeGenerator(BuilderOptions options) =>
    SharedPartBuilder([StoreGenerator()], 'store_generator');
