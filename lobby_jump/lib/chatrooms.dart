import 'dart:ui';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lobby_jump/models/conference.dart';
import 'auth.dart';
import 'initial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

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
      topictext = values.keys;
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

    getTopics() {
      List<int> indexes = [];
      var max1 = values.values.elementAt(0);
      var aux1 = 0;
      for (int index = 1; index < 5; index++) {
        if (values.values.elementAt(index) > max1) {
          max1 = values.values.elementAt(index);
          aux1 = index;
        }
      }
      indexes.insert(0, aux1);

      var max2;
      for (int index = 0; index < 5; index++) {
        if (index != aux1) {
          max2 = values.values.elementAt(index);
          break;
        }
      }
      var aux2 = 0;
      for (int index = 0; index < 5; index++) {
        if (index != aux1) {
          if (values.values.elementAt(index) > max2) {
            max2 = values.values.elementAt(index);
            aux2 = index;
          }
        }
      }
      indexes.insert(1, aux2);

      var max3;
      for (int index = 0; index < 5; index++) {
        if (index != aux2 && index != aux1) {
          max3 = values.values.elementAt(index);
          break;
        }
      }
      var aux3 = 0;
      for (int index = 0; index < 5; index++) {
        if (index != aux2 && index != aux1) {
          if (values.values.elementAt(index) > max3) {
            max3 = values.values.elementAt(index);
            aux3 = index;
          }
        }
      }
      indexes.insert(2, aux3);
      return indexes;
    }

    List<GestureDetector> _buildGridCards() {
      int count = 3; //rever
      var indexes = getTopics();
      List<GestureDetector> cards = List.generate(
        count,
        (int index) => GestureDetector(
          onTap: () => {_joinChatRoom(indexes.elementAt(index))},
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
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 65.0, 0, 0),
                          child: Text(
                              values.keys.elementAt(indexes.elementAt(index)),
                              style: TextStyle(fontSize: 25))),
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
        title: Transform(
            transform: Matrix4.translationValues(-55.0, 0.0, 0.0),
            child: const Text('Chatrooms available')),
        leading: new Container(),
        backgroundColor: Color.fromRGBO(88, 0, 0, 1),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.house_outlined),
              color: Colors.grey[600],
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }),
          /* new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white))) */
        ],
      ),
      backgroundColor: Color.fromRGBO(88, 0, 0, 1),
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
