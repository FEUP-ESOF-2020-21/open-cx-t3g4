import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lobby_jump/chatroom.dart';
import 'package:lobby_jump/sign_button.dart';
import 'auth.dart';
import 'initial_page.dart';
import 'joinmeeting.dart';

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
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout',
                    style: new TextStyle(
                        fontSize: 17.0, color: Color.fromRGBO(88, 0, 0, 1))
                        ))
          ],
        ),
      backgroundColor: Color.fromRGBO(88, 0, 0, 1),
      body: Column(children: [
        Container(
          child: Image.asset('lib/images/logo.png'),
          padding: EdgeInsets.only(bottom: 110, top: 150, left: 10, right: 10),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chatroom(auth: auth, onSignOut: () =>
                          onSignOut)),
              );
            },
            child: Text(
              "Create Meeting",
              style: TextStyle(color: Color.fromRGBO(88, 0, 0, 1)),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: new RaisedButton(
            onPressed: () {
              Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Join()));
            },
            child: Text(
              "Join Meeting",
              style: TextStyle(color: Color.fromRGBO(88, 0, 0, 1)),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: new RaisedButton(
            onPressed: () {},
            child: Text(
              "Join Chat Room",
              style: TextStyle(color: Color.fromRGBO(88, 0, 0, 1)),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        )
      ]),
    );
  }
}
