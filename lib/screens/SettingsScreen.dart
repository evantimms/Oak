import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: ListView(
          // TODO: Use the ListView.builder constructor to return settings based on user information
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Evan'),
              trailing: Icon(Icons.arrow_forward),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('timmsevan@gmail.com'),
              trailing: Icon(Icons.arrow_forward),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Log Out'),
              trailing: Icon(Icons.arrow_forward),
            )
          ],
        ),
      )
    );
  } 
}