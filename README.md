[![pub package](https://img.shields.io/pub/v/settings_manager.svg?label=settings_manager&color=blue)](https://pub.dartlang.org/packages/settings_manager)
[![pub package](https://img.shields.io/pub/v/settings_gen.svg?label=settings_gen&color=blue)](https://pub.dartlang.org/packages/settings_gen)
[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)

# Settings Manager

- Flutter settings store built on top of [shared preferences](https://pub.dev/packages/shared_preferences).
- Code Generator for supported types

## Usage

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

```

## Example

```dart
import 'package:flutter/material.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _settings = Settings();

  @override
  void initState() {
    _settings.init().then((ready) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _settings.counterValueStream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _settings.counterValue = snapshot.data + 1,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          );
        });
  }
}

```
