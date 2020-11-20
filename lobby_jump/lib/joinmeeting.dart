import 'package:flutter/material.dart';

import 'package:jitsi_meet/jitsi_meet.dart';

import 'auth.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
  
  final BaseAuth auth;
  final VoidCallback onSignOut;
  Join({this.auth, this.onSignOut});
}

class _JoinState extends State<Join> {
  final _formKey = GlobalKey<FormState>();
  String _formMeetingId = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    onSaved: (value) => _formMeetingId = value,
                    decoration: InputDecoration(
                      labelText: 'Enter a MeetingID',
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Enter Meeting ID";
                      return null;
                    },
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        print(_formMeetingId);
        var options = JitsiMeetingOptions()..room = _formMeetingId;

        await JitsiMeet.joinMeeting(options);
      } catch (error) {
        debugPrint("error: $error");
      }
    }
  }
}
