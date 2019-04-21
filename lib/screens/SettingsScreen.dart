import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({ this.signout });

  final VoidCallback signout;

  _SettingScreenState createState() => new _SettingScreenState();

}

class _SettingScreenState extends State<SettingsScreen>{
  bool _requestingLogOut = false;


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
              onTap: (){ 
                setState((){_requestingLogOut = true;});
              }
            ),
            (_requestingLogOut == true) ?
            AlertDialog(
              title: Text('Are you sure you want to logout?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: (){
                    widget.signout();
                    Navigator.pushNamed(context, '/');
                  },
                ),
                FlatButton(
                  child: Text('Go Back'),
                  onPressed: (){
                    setState(() {_requestingLogOut = false;});
                  },
                )
              ],
            ) 
            :
            Container(height: 0.0)
          ],
        )
      )
    );
  } 
}