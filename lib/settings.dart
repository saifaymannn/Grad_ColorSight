import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_profile_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    var colorProvider = Provider.of<ColorProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications_active),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              // Add navigation to language selection screen or logic
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Theme'),
            onTap: () {
              // Add navigation to theme selection screen or logic
            },
          ),
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Color Blind Mode: None'),
            onTap: () => colorProvider.setColorBlindMode(ColorBlindnessType.none),
          ),
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Color Blind Mode: Protanopia'),
            onTap: () => colorProvider.setColorBlindMode(ColorBlindnessType.protanopia),
          ),
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Color Blind Mode: Deuteranopia'),
            onTap: () => colorProvider.setColorBlindMode(ColorBlindnessType.deuteranopia),
          ),
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Color Blind Mode: Tritanopia'),
            onTap: () => colorProvider.setColorBlindMode(ColorBlindnessType.tritanopia),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacy & Security'),
            onTap: () {
              // Add navigation to privacy & security settings or logic
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              // Add navigation to about page or dialog
            },
          ),
        ],
      ),
    );
  }
}
