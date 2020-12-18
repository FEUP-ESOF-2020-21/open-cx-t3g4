import 'dart:ui';
import 'dart:io';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lobby_jump/models/conference.dart';
import 'auth.dart';
import 'survey.dart';
import 'initial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'joinmeeting.dart';

class Chatrooms extends StatefulWidget {
  Chatrooms({this.auth, this.onSignOut, this.conferenceKey});
  final BaseAuth auth;
  final VoidCallback onSignOut;
  final String conferenceKey;

  @override
  _ChatroomsState createState() => _ChatroomsState();
}

class _ChatroomsState extends State<Chatrooms> {
  DatabaseReference conferenceRef;
  List<Conference> conferences = List();
  Map<String, dynamic> topics;
  Conference conference;
  var topictext;
  Map<dynamic, dynamic> values;
  SplayTreeMap<String, dynamic> aux = SplayTreeMap<String, dynamic>();

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    conferenceRef = database.reference().child('conferences');
    conferenceRef.onChildAdded.listen(_onEntryAdded);
    //conferenceRef.onChildChanged.listen(_onEntryChanged);

    /*  conferenceRef.
    var keys = conference.topics.keys;
    var values = conference.topics.values;
    print("------------------------------------------------------");
    print(conference.topics.values.toSet()); */

    var topicsref = conferenceRef.child(widget.conferenceKey).child('topics');

    topicsref.once().then((DataSnapshot snapshot) async {
      values = await snapshot.value;
      topictext =values.keys;

    });
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

    _joinChatRoom(int index) async {
      var options = JitsiMeetingOptions()
        ..room = this.topictext.elementAt(index);
      await JitsiMeet.joinMeeting(options);
    }

    List<GestureDetector> _buildGridCards() {
      int count = 5; //rever
      List<GestureDetector> cards = List.generate(
        count,
        (int index) => GestureDetector(
          onTap: () => {_joinChatRoom(index)},
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(values.keys.elementAt(index)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      return cards;
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
      /* body: FirebaseAnimatedList(
            query: conferenceRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return new ListTile(title: Text(conferences[index].displayName));
            }) */
      body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards()),
    );
  }

  void _onEntryAdded(Event event) {
    setState(() {
      conference = Conference.fromSnapshot(event.snapshot);
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
