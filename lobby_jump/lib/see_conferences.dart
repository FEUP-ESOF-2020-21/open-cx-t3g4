import 'dart:ui';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lobby_jump/models/conference.dart';
import 'auth.dart';
import 'initial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';

class SeeConferences extends StatefulWidget {
  SeeConferences({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _SeeConferencesState createState() => _SeeConferencesState();
}

class _SeeConferencesState extends State<SeeConferences> {
  DatabaseReference conferenceRef;
  List<Conference> conferences = List();

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    conferenceRef = database.reference().child('conferences');
    conferenceRef.onChildAdded.listen(_onEntryAdded);
    conferenceRef.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await widget.auth.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InitialPage()),
        );
        widget.onSignOut();
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
        body: FirebaseAnimatedList(
            query: conferenceRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return new ListTile(title: Text(conferences[index].displayName));
            }));
  }

  void _onEntryAdded(Event event) {
    setState(() {
      conferences.add(Conference.fromSnapshot(event.snapshot));
    });
  }

  void _onEntryChanged(Event event) {
    var old = conferences.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      conferences[conferences.indexOf(old)] =
          Conference.fromSnapshot(event.snapshot);
    });
  }
}
