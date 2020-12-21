import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lobby_jump/models/conference.dart';
import 'auth.dart';
import 'initial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

class CreateConference extends StatefulWidget {
  @override
  _CreateConferenceState createState() => _CreateConferenceState();

  final BaseAuth auth;
  final VoidCallback onSignOut;
  CreateConference({this.auth, this.onSignOut});
}

class _CreateConferenceState extends State<CreateConference> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var serverText = TextEditingController();
  var roomText = TextEditingController();
  var subjectText = TextEditingController();
  var nameText = TextEditingController();
  var emailText = TextEditingController(text: "fake@email.com");
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;
  var topic1 = "";
  var topic2 = "";
  var topic3 = "";
  var topic4 = "";
  var topic5 = "";
  Conference conference;

  DatabaseReference conferenceRef;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    conference = Conference("", "", "", false, false, true, {});

    final FirebaseDatabase database = FirebaseDatabase.instance;
    conferenceRef = database.reference().child('conferences');
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: Transform(
              transform: Matrix4.translationValues(-55.0, 0.0, 0.0),
              child: const Text('Create Conference')),
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
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    onChanged: (val) => conference.conferenceName = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Conference Name",
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    onChanged: (val) => conference.subject = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Subject",
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    onChanged: (val) => conference.displayName = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Display Name",
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 50,
                    child: Text(
                        "Insert five topics related to the conference theme:",
                        style: TextStyle(fontSize: 17)),
                  ),
                  TextFormField(
                    onChanged: (val) => topic1 = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "First Topic",
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    onChanged: (val) => topic2 = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Second Topic",
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    onChanged: (val) => topic3 = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Third Topic",
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    onChanged: (val) => topic4 = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Fourth Topic",
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    onChanged: (val) => topic5 = val,
                    validator: (val) => val == "" ? val : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Fifth Topic",
                    ),
                  ),
                  Divider(
                    height: 48.0,
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 64.0,
                    width: double.maxFinite,
                    child: RaisedButton(
                      onPressed: () {
                        _joinMeeting();
                      },
                      child: Text(
                        "Create Conference",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color.fromRGBO(88, 0, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, int message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    String text;

    if (message == 0) {
      text = "Topics can not be empty";
    } else if (message == 1) {
      text = "Conference name can not be empty";
    } else if (message == 2) {
      text = "Conference name can not have empty spaces";
    } else if (message == 3) {
      text = "Topics can not have empty spaces";
    }

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error:"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _joinMeeting() async {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
    }

    if (topic1.isEmpty ||
        topic2.isEmpty ||
        topic3.isEmpty ||
        topic4.isEmpty ||
        topic5.isEmpty) {
      showAlertDialog(this.context, 0);
    } else {
      if (conference.conferenceName.isEmpty) {
        showAlertDialog(this.context, 1);
      } else {
        if (conference.conferenceName.contains(" ")) {
          showAlertDialog(this.context, 2);
        } else {
          if (topic1.contains(" ") ||
              topic2.contains(" ") ||
              topic3.contains(" ") ||
              topic4.contains(" ") ||
              topic5.contains(" ")) {
            showAlertDialog(this.context, 3);
          } else {
            conference.topics.addAll({topic1: 0});
            conference.topics.addAll({topic2: 0});
            conference.topics.addAll({topic3: 0});
            conference.topics.addAll({topic4: 0});
            conference.topics.addAll({topic5: 0});

            conferenceRef.push().set(conference.toJson());

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
                ..room = conference.conferenceName
                ..serverURL = serverUrl
                ..subject = conference.subject
                ..userDisplayName = conference.displayName
                ..userEmail = emailText.text
                ..audioOnly = isAudioOnly
                ..audioMuted = isAudioMuted
                ..videoMuted = isVideoMuted
                ..featureFlags.addAll(featureFlags);

              debugPrint("JitsiMeetingOptions: $options");
              await JitsiMeet.joinMeeting(
                options,
                listener:
                    JitsiMeetingListener(onConferenceWillJoin: ({message}) {
                  debugPrint(
                      "${options.room} will join with message: $message");
                }, onConferenceJoined: ({message}) {
                  debugPrint("${options.room} joined with message: $message");
                }, onConferenceTerminated: ({message}) {
                  debugPrint(
                      "${options.room} terminated with message: $message");
                }),
                // by default, plugin default constraints are used
                //roomNameConstraints: new Map(), // to disable all constraints
                //roomNameConstraints: customContraints, // to use your own constraint(s)
              );
/*
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Chatrooms(
                  auth: widget.auth,
                  onSignOut: () => widget.onSignOut,
                  conferenceKey: conference.key)));*/
            } catch (error) {
              debugPrint("error: $error");
            }
          }
        }
      }
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
