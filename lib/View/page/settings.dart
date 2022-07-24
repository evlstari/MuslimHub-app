import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_flutter/main.dart';
import 'package:project_flutter/view/home.dart';
import 'package:project_flutter/viewModel/helper/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Consumer<ThemeNotifier>(
              builder: (context, notifier, child) {
                return SwitchListTile(
                  title: notifier.darkMode ? Text("Light Mode") : Text("Dark Mode"),
                    value: notifier.darkMode,
                    onChanged: (val){
                      notifier.toggleChangeTheme();
                    });
              },
            )));
  }
}
