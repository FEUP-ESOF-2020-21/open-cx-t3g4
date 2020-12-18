import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lobby_jump/create_conference.dart';
import 'auth.dart';
import 'initial_page.dart';
import 'joinmeeting.dart';
import 'see_conferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';

class ConferenceMenu extends StatelessWidget {
  ConferenceMenu({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "chatroom");
  final subjectText = TextEditingController(text: "Virtual Reality");
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;
  createChatRoom() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        //..userDisplayName = nameText.text
        //..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

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
          height: 70.0,
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
          padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
          width: 300.0,
          height: 70.0,
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
