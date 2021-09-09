import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/http_response_message.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up for Edil Lottery"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 230.0, left: 50.0, right: 50.0),
            height: 550.0,
            child: Form(
                child: Column(
              children: <Widget>[
                _fullnameField(formBloc),
                _usernameField(formBloc),
                _phonenumberField(formBloc),
                _emailField(formBloc),
                _passwordField(formBloc),
                Container(
                  width: 300,
                  height: 35,
                  child: HttpResponseMessage.AddHttpResponse(formBloc),
                ),
                _button(formBloc),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _fullnameField(FormBloc formBloc) {
    return StreamBuilder<Object>(
        stream: formBloc.name,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "enter your full name",
                labelText: "Fullname",
                errorText: snapshot.error),
            onChanged: formBloc.changeName,
          );
        });
  }

  Widget _phonenumberField(FormBloc formBloc) {
    return StreamBuilder<Object>(
        stream: formBloc.cellphone,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "enter your your phone number",
                labelText: "Phone Number",
                errorText: snapshot.error),
            onChanged: formBloc.changeCellphone,
          );
        });
  }

  Widget _usernameField(FormBloc formBloc) {
    return StreamBuilder<Object>(
        stream: formBloc.username,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: "enter your username",
                labelText: "Username",
                errorText: snapshot.error),
            onChanged: formBloc.changeUsername,
          );
        });
  }

  Widget _emailField(FormBloc formBloc) {
    return StreamBuilder<Object>(
        stream: formBloc.email,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: "you@example.com",
                labelText: "Email",
                errorText: snapshot.error),
            onChanged: formBloc.changeEmail,
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

  Widget _button(FormBloc formBloc) {
    FormBloc formBloc = Provider.of(context);
    void _signupNavigator(FormBloc formBloc, SignupData signupData) async {
      http.Response res = await formBloc.httpService.register(signupData);
      try {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          formBloc.addHttpResponseMessage(data["message"]);
          Navigator.pop(context);
        } else {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          formBloc.addHttpResponseMessage(data["message"]);
          print(data['message']);
          throw Exception(data);
        }
      } catch (e) {
        print("Exception happened in register");
      }
    }

    return StreamBuilder<SignupData>(
        stream: formBloc.submitValidSignup,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: () {
                if (snapshot.hasError) {
                  print("has error");
                  return null;
                } else {
                  _signupNavigator(formBloc, snapshot.data);
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
}
