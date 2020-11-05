import 'package:flutter/material.dart';
import 'package:lobby_jump/home_page.dart';
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
        validator: (val) => val.isEmpty ? 'Email can\'t be empty.' : null,
        onChanged: (val) => _email = val,
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
            validator: (val) =>
                val.isEmpty ? 'Password can\'t be empty.' : null,
            onChanged: (val) => _password = val,
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

  void validateAndSubmit() async {
    try {
      auth.signIn(_email, _password);

      _updateAuthStatus(AuthStatus.signedIn);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  auth: auth,
                  onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),
                )),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("goback"),
        iconTheme: IconThemeData(color: Color.fromRGBO(88, 0, 0, 1)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          child: Image.asset('lib/images/symbol.png'),
          padding: EdgeInsets.only(bottom: 5, top: 30, left: 10, right: 10),
        ),
        Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 125),
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
      ]),
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
