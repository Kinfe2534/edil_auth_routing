import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/service/validation_mixin.dart';
import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

import 'auth_service.dart';

class FormBloc with ValidationMixin {
  final _username = new BehaviorSubject<String>();
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _name = new BehaviorSubject<String>();
  final _cellphone = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();

  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeCellphone => _cellphone.sink.add;
  Function(String) get addError => _errorMessage.sink.add;

  Stream<String> get username => _username.stream.transform(validatorUsername);
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String> get name => _name.stream.transform(validatorFullname);
  Stream<String> get cellphone =>
      _cellphone.stream.transform(validatorPhonenumber);
  Stream<String> get errorMessage => _errorMessage.stream;

  Stream<bool> get submitValidSignup => Rx.combineLatest5(
      username, email, password, name, cellphone, (un, e, p, n, cp) => true);
  Stream<bool> get submitValidLogin =>
      Rx.combineLatest2(username, password, (un, p) => true);

  var authInfo;
  var registerData;
  var loginData;
  var userData;

  //register
  dynamic register(BuildContext context) async {
    authInfo = AuthService();
    registerData = SignupData(
      username: _username.value,
      email: _email.value,
      password: _password.value,
      name: _name.value,
      cellphone: _cellphone.value,
    );
    final res = await authInfo.register(registerData);
    final data = jsonDecode(res.body) as Map<String, dynamic>;

    if (res.statusCode == 200) {
      print('Register statusCode equal to 200');
      addError(data['message']);

      print(data.toString());
      AuthService.setToken(data['token'], data['refreshtoken']);
      Navigator.pop(context);
      //Navigator.pushNamed(context, '/home');
      return data;
    } else {
      print('Register statusCode not equal to 200');
      addError(data['message']);
    }
    print(res.statusCode);
  }

  //login
  dynamic login(BuildContext context) async {
    authInfo = AuthService();
    loginData = LoginData(username: _username.value, password: _password.value);
    final res = await authInfo.login(loginData);
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      //Map<String, dynamic> data = jsonDecode(res.body);
      print('Login statusCode equal to 200');
      addError(data['message']);
      userData = UserData.fromJson(data);
      AuthService.setToken(data['token'], data['refreshtoken']);
      Navigator.pushNamed(context, '/lotteriesPageLoggedIn');
      return data;
    } else {
      print('Login statusCode not equal to 200');
      addError(data['message']);
    }
    print(res.statusCode);
  }
  //submit button
  //submit() {
  //_email.value;
  // _password.value;
  // }

  dispose() {
    _username.close();
    _email.close();
    _password.close();
    _name.close();
    _cellphone.close();
    _errorMessage.close();
  }
}