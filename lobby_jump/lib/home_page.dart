import 'package:flutter/material.dart';
import 'package:lobby_jump/initial_page.dart';
import 'auth.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
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

    return new Scaffold(
        appBar: new AppBar(
          leading: new Container(),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout',
                    style: new TextStyle(
                        fontSize: 17.0, color: Color.fromRGBO(88, 0, 0, 1))))
          ],
        ),
        backgroundColor: Colors.white,
        body: new Center(
          child: new Text(
            'Signed In',
            style: new TextStyle(
                fontSize: 32.0, color: Color.fromRGBO(88, 0, 0, 1)),
          ),
        ));
  }
}
