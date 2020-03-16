/// Declares configuration of a SettingsStore class.
/// Currently the only configuration used is boolean to indicate generation of toString method (true), or not (false)

class SettingsConfig {
  const SettingsConfig({this.hasToString = true});
  final bool hasToString;
}

class BoolSetting {
  const BoolSetting({
    this.defaultValue,
    this.addStream = true,
    this.addValueNotifer = true,
  });
  final bool defaultValue;
  final bool addStream;
  final bool addValueNotifer;
}

class StringSetting {
  const StringSetting({
    this.defaultValue,
    this.addStream = true,
    this.addValueNotifer = true,
  });
  final String defaultValue;
  final bool addStream;
  final bool addValueNotifer;
}
