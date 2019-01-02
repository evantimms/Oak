import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {

  @override
  _NotesScreenState createState()=> new _NotesScreenState(); 
}

class _NotesScreenState extends State<NotesScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context){
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            TabBar(
              labelColor: Colors.black,
              labelPadding: EdgeInsets.symmetric(horizontal: 25.0),
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  text: "Saved Notes",
                ),
                Tab(
                  text: "Featured Notes",
                )
              ],
            ),
            SizedBox(
              height: 300.0,
              child: TabBarView(
                children: <Widget>[
                  ListView(
                    //TODO: Implement Card View
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Card(
                          ),
                          Card(),
                        ],
                      )
                    ]
                  ),
                  Center(
                    child: Text(
                      "Featured Notes"
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    
    );
      
  }
}
