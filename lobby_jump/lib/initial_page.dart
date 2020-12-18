import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lobby_jump/sign_button.dart';
import 'sign_button.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(88, 0, 0, 1),
      body: Column(children: [
        Container(
          child: Image.asset('lib/images/logo.png'),
          padding: EdgeInsets.only(bottom: 110, top: 150, left: 10, right: 10),
        ),
        Container(
            height: 90,
            padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child: new SignButton(
              key: new Key('login'),
              text: "LOGIN",
              colorButton: 1,
              function: 1,
            )),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 70,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: new SignButton(
            key: new Key('signup'),
            text: "SIGN UP",
            colorButton: 0,
            function: 0,
          ),
        )
      ]),
    );
  }
}
