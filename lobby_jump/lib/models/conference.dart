import 'package:firebase_database/firebase_database.dart';

class Conference {
  String key;
  String conferenceName;
  String subject;
  String displayName;

  bool audioOnly;
  bool audioOn;
  bool videoOn;

  Conference(this.conferenceName, this.subject, this.displayName,
      this.audioOnly, this.audioOn, this.videoOn);

  Conference.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        conferenceName = snapshot.value["conferenceName"],
        subject = snapshot.value["subject"],
        displayName = snapshot.value["displayName"],
        audioOnly = snapshot.value["audioOnly"],
        audioOn = snapshot.value["audioOn"],
        videoOn = snapshot.value["videoOn"];

  toJson() {
    return {
      "conferenceName": conferenceName,
      "subject": subject,
      "displayName": displayName,
      "audioOnly": audioOnly,
      "audioOn": audioOn,
      "videoOn": videoOn
    };
  }
}
