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
  String defaultUserId;
}
