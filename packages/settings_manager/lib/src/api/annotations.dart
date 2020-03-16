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
    this.addValueNotifier = true,
  });
  final bool defaultValue;
  final bool addStream;
  final bool addValueNotifier;
}

class StringSetting {
  const StringSetting({
    this.defaultValue,
    this.addStream = true,
    this.addValueNotifier = true,
  });
  final String defaultValue;
  final bool addStream;
  final bool addValueNotifier;
}

class IntSetting {
  const IntSetting({
    this.defaultValue,
    this.addStream = true,
    this.addValueNotifier = true,
  });
  final int defaultValue;
  final bool addStream;
  final bool addValueNotifier;
}

class DoubleSetting {
  const DoubleSetting({
    this.defaultValue,
    this.addStream = true,
    this.addValueNotifier = true,
  });
  final double defaultValue;
  final bool addStream;
  final bool addValueNotifier;
}

class StringListSetting {
  const StringListSetting({
    this.defaultValue,
    this.addStream = true,
    this.addValueNotifier = true,
  });
  final List<String> defaultValue;
  final bool addStream;
  final bool addValueNotifier;
}
