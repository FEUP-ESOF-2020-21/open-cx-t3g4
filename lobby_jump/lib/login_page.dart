import 'package:flutter/material.dart';
import 'package:lobby_jump/chatroom.dart';
import 'package:lobby_jump/conference_menu.dart';
import 'auth.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType { login, register }

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  bool _showPassword = true;
  FocusNode myFocusNode = new FocusNode();
  BaseAuth auth = new Auth();
  AuthStatus authStatus = AuthStatus.notSignedIn;
  final _formKey = new GlobalKey<FormState>();

  List<Widget> usernameAndPassword() {
    return [
      padded(
          child: new TextFormField(
        key: new Key('email'),
        decoration: new InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(88, 0, 0, 1))),
            labelText: 'Email',
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus
                    ? Colors.black
                    : Color.fromRGBO(88, 0, 0, 1))),
        autocorrect: false,
        onChanged: (value) => _email = value.trim(),
        validator: (value) {
          if (value.isEmpty) {
            return 'Email can\'t be empty.';
          }
          if (value.contains(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')) {
            return 'Invalid Email';
          }
          return null;
        },
      )),
      padded(
          child: Row(
        children: [
          Expanded(
              child: new TextFormField(
            key: new Key('password'),
            decoration: new InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(88, 0, 0, 1))),
              labelText: 'Password',
              labelStyle: TextStyle(
                  color: myFocusNode.hasFocus
                      ? Colors.black
                      : Color.fromRGBO(88, 0, 0, 1)),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: this._showPassword ? Colors.grey : Colors.blue,
                ),
                onPressed: () {
                  setState(() => this._showPassword = !this._showPassword);
                },
              ),
            ),
            obscureText: _showPassword,
            autocorrect: false,
            validator: (value) =>
                value.isEmpty ? 'Password can\'t be empty.' : null,
            onChanged: (value) => _password = value,
          )),
        ],
      )),
    ];
  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    String userId = '';
    try {
      if (validateAndSave()) {
        userId = await auth.signIn(_email, _password);
        if (userId.length > 0 && userId != null) {
          _updateAuthStatus(AuthStatus.signedIn);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => new ConferenceMenu(auth: auth, onSignOut: () =>
                          _updateAuthStatus(AuthStatus.notSignedIn)),
                /* Chatroom(
                      auth: auth,
                      onSignOut: () =>
                          _updateAuthStatus(AuthStatus.notSignedIn),
                    ) */
                    ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: new Form(
          key: _formKey,
          child: Column(children: [
            Container(
              child: IconButton(
                  icon: Icon(Icons.house_outlined),
                  color: Colors.grey[600],
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              padding:
                  EdgeInsets.only(bottom: 10, top: 40, left: 10, right: 310),
            ),
            Container(
              child: Image.asset('lib/images/symbol.png'),
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 100),
                child: new Column(
                  children: usernameAndPassword(),
                )),
            Container(
              height: 50.0,
              width: 300.0,
              child: GestureDetector(
                onTap: () {
                  validateAndSubmit();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Color.fromRGBO(88, 0, 0, 1),
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
            )
          ])),
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
