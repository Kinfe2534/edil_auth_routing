import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/helper.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loggedInStatus = true;
  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
            height: 550.0,
            child: Form(
                child: Column(
              children: <Widget>[
                _usernameField(formBloc),
                _passwordField(formBloc),
                Container(
                  width: 300,
                  height: 35,
                  child: Helper.errorMessage(formBloc),
                ),
                Row(
                  children: [
                    _checkbox(),
                    GestureDetector(
                      child: Text('   Register'),
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                    )
                  ],
                ),
                _button(formBloc),
                _forgotPasswordButton(context),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _usernameField(FormBloc formBloc) {
    return StreamBuilder<Object>(
        stream: formBloc.username,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "enter your username",
                labelText: "Username",
                errorText: snapshot.error),
            onChanged: formBloc.changeUsername,
          );
        });
  }

  Widget _passwordField(FormBloc formBloc) {
    return StreamBuilder<Object>(
        stream: formBloc.password,
        builder: (context, snapshot) {
          return TextField(
            maxLength: 20,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "password",
                labelText: "Password",
                errorText: snapshot.error),
            onChanged: formBloc.changePassword,
          );
        });
  }

  Widget _checkbox() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _loggedInStatus,
          onChanged: (checked) => {
            setState(() {
              _loggedInStatus = checked;
            })
          },
        ),
        Text("keep me logged in"),
      ],
    );
  }

  Widget _button(FormBloc formBloc) {
    FormBloc formBloc = Provider.of(context);
    void _loginNavigator(FormBloc formBloc, LoginData loginData) async {
      http.Response res = await formBloc.httpService.login(loginData);
      try {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          formBloc.userData = UserData.fromJson(data);
          formBloc.addError(data['message']);
          Navigator.pushNamed(context, '/lotteriesPageLoggedIn');
        } else if (res.statusCode == 401) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          formBloc.addError(data['message']);
        } else {
          throw Exception("Failed to login");
        }
      } catch (e) {
        print("Exception happened in login");
      }
    }

    return StreamBuilder<LoginData>(
        stream: formBloc.submitValidLogin,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: () {
                if (snapshot.hasError) {
                  print("has error");
                  return null;
                } else {
                  _loginNavigator(formBloc, snapshot.data);
                }
              },
              child: const Icon(Icons.arrow_forward),
              color: Colors.amber,
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              disabledColor: Colors.blueGrey,
              disabledElevation: 10,
              disabledTextColor: Colors.white,
            ),
          );
        });
  }

  Widget _forgotPasswordButton(BuildContext context) {
    return Row(children: <Widget>[
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/forgot'),
        child: Container(
          child: Text('Forgot password ?'),
          alignment: Alignment.bottomLeft,
        ),
      )
    ]);
  }
}
