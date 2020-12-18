import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:lobby_jump/chatrooms.dart';
import 'package:lobby_jump/models/conference.dart';

import 'auth.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();

  final BaseAuth auth;
  final VoidCallback onSignOut;
  final Conference conference;
  Survey({this.auth, this.onSignOut, this.conference});
}

class _SurveyState extends State<Survey> {
  DatabaseReference conferenceRef;

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    conferenceRef = database.reference().child('conferences');
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String _formMeetingId = '';

  var topics = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    List<CheckboxListTile> _buildCheckboxes() {
      int count = 5;
      var keys = widget.conference.topics.keys;

      List<CheckboxListTile> checkboxes = List.generate(
        count,
        (int index) => CheckboxListTile(
          onChanged: (bool value) {
            setState(() {
              topics[index] = value;
            });
          },
          value: topics[index],
          title: Text(keys.elementAt(index)),
        ),
      );

      return checkboxes;
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(40),
                child: Form(
                  child: Column(
                    children: _buildCheckboxes(),
                  ),
                ),
              ),
              RaisedButton(
                  onPressed: () => _joinMeeting(),
                  child: Text('Join Meeting',
                      style:
                          new TextStyle(fontSize: 17.0, color: Colors.white)),
                  color: Color.fromRGBO(88, 0, 0, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ))
            ],
          ),
        )));
  }

  _joinMeeting() async {
    var keys = widget.conference.topics.keys;
    var values = widget.conference.topics.values;

    int val0 = values.elementAt(0);
    int val1 = values.elementAt(1);
    int val2 = values.elementAt(2);
    int val3 = values.elementAt(3);
    int val4 = values.elementAt(4);

    int newval0;
    int newval1;
    int newval2;
    int newval3;
    int newval4;
    if (topics[0] == true)
      newval0 = val0 + 1;
    else
      newval0 = val0;

    if (topics[1] == true)
      newval1 = val1 + 1;
    else
      newval1 = val1;

    if (topics[2] == true)
      newval2 = val2 + 1;
    else
      newval2 = val2;

    if (topics[3] == true)
      newval3 = val3 + 1;
    else
      newval3 = val3;

    if (topics[4] == true)
      newval4 = val4 + 1;
    else
      newval4 = val4;

    conferenceRef
        .child(widget.conference.key)
        .child('topics')
        .update({keys.elementAt(0): newval0});

    conferenceRef
        .child(widget.conference.key)
        .child('topics')
        .update({keys.elementAt(1): newval1});

    conferenceRef
        .child(widget.conference.key)
        .child('topics')
        .update({keys.elementAt(2): newval2});

    conferenceRef
        .child(widget.conference.key)
        .child('topics')
        .update({keys.elementAt(3): newval3});

    conferenceRef
        .child(widget.conference.key)
        .child('topics')
        .update({keys.elementAt(4): newval4});

    
    try {
      print(widget.conference.conferenceName);
      var options = JitsiMeetingOptions()..room = widget.conference.conferenceName;

      await JitsiMeet.joinMeeting(options);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Chatrooms(
                          auth: widget.auth, onSignOut: () => widget.onSignOut, conferenceKey: widget.conference.key)));
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
