//import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/validation_mixin.dart';
//import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

import 'package:edil/service/http_service.dart';

class FormBloc with ValidationMixin {
  UserData userData;
  HttpService httpService = HttpService();
  List<TicketOrder> ticketsTobuy = [
    new TicketOrder(
        user_id: 1, loto_numbers: "sample", lottery_id: 1, cost: 10),
    new TicketOrder(user_id: 2, loto_numbers: "sample", lottery_id: 1, cost: 10)
  ];

  final _username = new BehaviorSubject<String>();
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _name = new BehaviorSubject<String>();
  final _cellphone = new BehaviorSubject<String>();
  final _ticketOrder = new BehaviorSubject<String>();
  final _digitField = new BehaviorSubject<String>();
  final _httpResponseMessage = new BehaviorSubject<String>();

  Stream<String> get username => _username.stream.transform(validatorUsername);
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String> get name => _name.stream.transform(validatorFullname);
  Stream<String> get cellphone =>
      _cellphone.stream.transform(validatorPhonenumber);
  Stream<String> get ticketOrder => _ticketOrder.stream;
  Stream<String> get digitField => _digitField.stream;
  Stream<String> get httpResponseMessage => _httpResponseMessage.stream;

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

  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeCellphone => _cellphone.sink.add;
  Function(String) get addTicketOrder => _ticketOrder.sink.add;
  Function(String) get addDigitField => _digitField.sink.add;
  Function(String) get addHttpResponseMessage => _httpResponseMessage.sink.add;
/*
  
      final _signupMessage = new BehaviorSubject<String>();
  final _loginMessage = new BehaviorSubject<String>();
  final _getAllLotteriesMessage = new BehaviorSubject<String>();
  final _getAllTicketsMessage = new BehaviorSubject<String>();
  final _createTicketMessage = new BehaviorSubject<String>();
  final _createLotteryMessage = new BehaviorSubject<String>();
  final _updateLotteryMessage = new BehaviorSubject<String>();
  final _getAllWinnersMessage = new BehaviorSubject<String>();
  final _drawMessage = new BehaviorSubject<String>();

  Function(String) get addSignupMessage => _signupMessage.sink.add;
  Function(String) get addLoginMessage => _loginMessage.sink.add;
  Function(String) get addGetAllLotteriesMessage =>
      _getAllLotteriesMessage.sink.add;
  Function(String) get addGetAllTicketsMessage =>
      _getAllTicketsMessage.sink.add;
  Function(String) get addcreateTicketMessage => _createTicketMessage.sink.add;
  Function(String) get addcreateLotteryMessage =>
      _createLotteryMessage.sink.add;
  Function(String) get addUpdateLotteryMessage =>
      _updateLotteryMessage.sink.add;
  Function(String) get addGetAllWinnersMessage =>
      _getAllWinnersMessage.sink.add;
  Function(String) get addDrawMessage => _drawMessage.sink.add;

  Stream<String> get signupMessage => _signupMessage.stream;
  Stream<String> get loginMessage => _loginMessage.stream;
  Stream<String> get getAllLotteriesMessage => _getAllLotteriesMessage.stream;
  Stream<String> get getAllTicketsMessage => _getAllTicketsMessage.stream;
  Stream<String> get createTicketMessage => _createTicketMessage.stream;
  Stream<String> get createLotteryMessage => _createLotteryMessage.stream;
  Stream<String> get updateLotteryMessage => _updateLotteryMessage.stream;
  Stream<String> get getAllWinnersMessage => _getAllWinnersMessage.stream;
  Stream<String> get drawMessage => _drawMessage.stream;
*/
  dispose() {
    _username.close();
    _email.close();
    _password.close();
    _name.close();
    _cellphone.close();
    _ticketOrder.close();
    _digitField.close();
    _httpResponseMessage.close();
    /*
    _signupMessage.close();
    _loginMessage.close();
    _createLotteryMessage.close();
    _createTicketMessage.close();
    _drawMessage.close();
    _getAllLotteriesMessage.close();
    _getAllTicketsMessage.close();
    _updateLotteryMessage.close();
    _getAllWinnersMessage.close();*/
  }
}
