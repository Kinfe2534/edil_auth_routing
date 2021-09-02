//import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/validation_mixin.dart';
//import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

import 'package:edil/service/http_service.dart';

class FormBloc with ValidationMixin {
  var httpService = HttpService();
  List<TicketOrder> ticketsTobuy = [
    new TicketOrder(
        user_id: 1, loto_numbers: "sample", lottery_id: 1, cost: 10),
    new TicketOrder(user_id: 2, loto_numbers: "sample", lottery_id: 1, cost: 10)
  ];

  final Uri lotteriesUrl = Uri.parse("http://localhost:8080/api/lottery/all");
  final Uri allTicketsUrl = Uri.parse("http://localhost:8080/api/ticket/all");
  final Uri signupUrl = Uri.parse("http://localhost:8080/api/auth/signup");
  final Uri loginUrl = Uri.parse("http://localhost:8080/api/auth/signin");

  final _username = new BehaviorSubject<String>();
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _name = new BehaviorSubject<String>();
  final _cellphone = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();
  final _ticketOrder = new BehaviorSubject<String>();

  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeCellphone => _cellphone.sink.add;
  Function(String) get addError => _errorMessage.sink.add;
  Function(String) get addTicketOrder => _ticketOrder.sink.add;

  Stream<String> get username => _username.stream.transform(validatorUsername);
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String> get name => _name.stream.transform(validatorFullname);
  Stream<String> get cellphone =>
      _cellphone.stream.transform(validatorPhonenumber);
  Stream<String> get errorMessage => _errorMessage.stream;
  Stream<String> get ticketOrder => _ticketOrder.stream;

  Stream<SignupData> get submitValidSignup =>
      Rx.combineLatest5(username, email, password, name, cellphone,
          (un, e, p, n, cp) {
        return SignupData(
          username: _username.value,
          email: _email.value,
          password: _password.value,
          name: _name.value,
          cellphone: _cellphone.value,
        );
      });
  Stream<LoginData> get submitValidLogin =>
      Rx.combineLatest2(username, password, (un, p) {
        return LoginData(username: _username.value, password: _password.value);
      });

  /*
  dynamic register(BuildContext context, SignupData signupData) async {
    final res = await authInfo.register(registerData, signupUrl);
    final data = jsonDecode(res.body) as Map<String, dynamic>;

    if (res.statusCode == 200) {
      print('Register statusCode equal to 200');
      addError(data['message']);

      print(data.toString());
      HttpService.setToken(data['token'], data['refreshtoken']);
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
    authInfo = HttpService();
    loginData = LoginData(username: _username.value, password: _password.value);
    final res = await authInfo.login(loginData, loginUrl);
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      //Map<String, dynamic> data = jsonDecode(res.body);
      print('Login statusCode equal to 200');
      addError(data['message']);
      userData = UserData.fromJson(data);
      HttpService.setToken(data['token'], data['refreshtoken']);
      Navigator.pushNamed(context, '/lotteriesPageLoggedIn');
      return data;
    } else {
      print('Login statusCode not equal to 200');
      addError(data['message']);
    }
    print(res.statusCode);
  }

  //creat Tciket
  dynamic createTciket(BuildContext context) async {
    loginData = LoginData(username: _username.value, password: _password.value);
    final res = await authInfo.login(loginData, loginUrl);
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      //Map<String, dynamic> data = jsonDecode(res.body);
      print('Login statusCode equal to 200');
      addError(data['message']);
      userData = UserData.fromJson(data);
      HttpService.setToken(data['token'], data['refreshtoken']);
      Navigator.pushNamed(context, '/lotteriesPageLoggedIn');
      return data;
    } else {
      print('Login statusCode not equal to 200');
      addError(data['message']);
    }
    print(res.statusCode);
  }
*/
  dispose() {
    _username.close();
    _email.close();
    _password.close();
    _name.close();
    _cellphone.close();
    _errorMessage.close();
    _ticketOrder.close();
  }
}
