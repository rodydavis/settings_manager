/// Declares configuration of a SettingsStore class.
/// Currently the only configuration used is boolean to indicate generation of toString method (true), or not (false)

class SettingsConfig {
  const SettingsConfig({this.hasToString = true});
  final bool hasToString;
}

class BoolSetting {
  const BoolSetting({this.defaultValue});
  final bool defaultValue;
}
