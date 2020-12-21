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
  Chatrooms({this.auth, this.onSignOut, this.conferenceKey, this.conferenceR});
  final BaseAuth auth;
  final VoidCallback onSignOut;
  final String conferenceKey;
  final Conference conferenceR;

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
      var aux2;
      for (int index = 0; index < 5; index++) {
        if (index != aux1) {
          max2 = values.values.elementAt(index);
          aux2 = index;
          break;
        }
      }

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
      var aux3;
      for (int index = 0; index < 5; index++) {
        if (index != aux2 && index != aux1) {
          max3 = values.values.elementAt(index);
          aux3 = index;
          break;
        }
      }
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
        leading: Transform(
            transform: Matrix4.translationValues(8.0, 3.0, 0.0),
            child: IconButton(
              onPressed: () async {
                var options = JitsiMeetingOptions()
                  ..room = widget.conferenceR.conferenceName;

                await JitsiMeet.joinMeeting(options);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.grey[600],
              iconSize: 35,
            )),
        backgroundColor: Color.fromRGBO(88, 0, 0, 1),
        actions: <Widget>[
          Transform(
              transform: Matrix4.translationValues(-78.0, 30.0, 0.0),
              child: Transform.scale(
                scale: 1.5,
                child: Text('Chatrooms available'),
              )),
          Transform(
              transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
              child: IconButton(
                  icon: Icon(Icons.house_outlined),
                  color: Colors.grey[600],
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }))
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
