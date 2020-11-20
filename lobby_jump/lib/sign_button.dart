import 'package:flutter/material.dart';
import 'package:lobby_jump/login_page.dart';
import 'package:lobby_jump/register_page.dart';
import 'package:flutter/cupertino.dart';

class SignButton extends StatelessWidget {
  SignButton({this.key, this.text, this.colorButton, this.function})
      : super(key: key);
  final Key key;
  final String text;
  final int colorButton;
  final int function;
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 50.0,
      width: 300.0,
      child: GestureDetector(
        onTap: () {
          function == 1
              ? Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: colorButton == 1
                ? Colors.white
                : colorButton == 3
                    ? Color.fromRGBO(88, 0, 0, 1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: colorButton == 1
                        ? Color.fromRGBO(88, 0, 0, 1)
                        : Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
