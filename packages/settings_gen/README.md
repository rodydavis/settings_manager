[![pub package](https://img.shields.io/pub/v/settings_manager.svg?label=settings_manager&color=blue)](https://pub.dartlang.org/packages/settings_manager)
[![pub package](https://img.shields.io/pub/v/settings_gen.svg?label=settings_gen&color=blue)](https://pub.dartlang.org/packages/settings_gen)

# settings_gen

Code generator for `settings_manager` built for use with SharedPreferences. This will add Streams and ValueNotifiers for each field.

```
$> cd $YOUR_PROJECT_DIR
$> flutter packages pub run build_runner build

```

### Example

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:settings_manager/settings_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.g.dart';

class Settings = SettingsBase with _$Settings;

abstract class SettingsBase with SettingsStore {
  @BoolSetting(defaultValue: false)
  bool darkMode;

  @StringSetting(defaultValue: 'none')
  String userId;

  @IntSetting(defaultValue: 0)
  int counterValue;

  @DoubleSetting(defaultValue: 0)
  double radialValue;

  @StringListSetting(defaultValue: [])
  List<String> savedItems;
}

````
