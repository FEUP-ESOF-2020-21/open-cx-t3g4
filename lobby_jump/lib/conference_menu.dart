import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lobby_jump/create_conference.dart';
import 'auth.dart';
import 'initial_page.dart';
import 'see_conferences.dart';
import 'package:flutter/cupertino.dart';

class ConferenceMenu extends StatelessWidget {
  ConferenceMenu({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await auth.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InitialPage()),
        );
        onSignOut();
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: new AppBar(
        leading: new Container(),
        backgroundColor: Color.fromRGBO(88, 0, 0, 1),
        elevation: 0,
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)))
        ],
      ),
      backgroundColor: Color.fromRGBO(88, 0, 0, 1),
      body: Column(children: [
        Container(
          child: Image.asset('lib/images/logo.png'),
          padding: EdgeInsets.only(bottom: 110, top: 80, left: 10, right: 10),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
          width: 300.0,
          height: 90.0,
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateConference(
                        auth: auth, onSignOut: () => onSignOut)),
              );
            },
            child: Text(
              "Create Conference",
              style: TextStyle(color: Color.fromRGBO(88, 0, 0, 1)),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
          width: 300.0,
          height: 90.0,
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeeConferences(
                          auth: auth, onSignOut: () => onSignOut)));
            },
            child: Text(
              "See available conferences",
              style: TextStyle(color: Color.fromRGBO(88, 0, 0, 1)),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ]),
    );
  }
}
