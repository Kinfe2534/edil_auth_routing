import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/model/lottery_model.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final Uri lotteriesUrl = Uri.parse("http://localhost:8080/api/lottery/all");
  final Uri allTicketsUrl = Uri.parse("http://localhost:8080/api/ticket/all");
  final Uri signupUrl = Uri.parse("http://localhost:8080/api/auth/signup");
  final Uri loginUrl = Uri.parse("http://localhost:8080/api/auth/signin");
  static final SESSION = FlutterSession();

  Future<List<Lottery>> getLotteries(Uri uri) async {
    http.Response res = await http.get(lotteriesUrl);
    try {
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<Lottery> lotteries =
            body.map((dynamic item) => Lottery.fromJson(item)).toList();
        return lotteries;
      } else {
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Ticket>> getAllTickets(Uri uri) async {
    http.Response res = await http.get(allTicketsUrl);
    try {
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<Ticket> tickets =
            body.map((dynamic item) => Ticket.fromJson(item)).toList();
        return tickets;
      } else {
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> register(SignupData signupData) async {
    try {
      var body = jsonEncode(signupData.toJson());
      http.Response res = await http.post(signupUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      return res;
    } catch (e) {
      print(e.toString());
    } finally {
      print("@Register ");
      print(jsonEncode(signupData));
      //done u can do sth here
    }
  }

  Future<dynamic> login(LoginData loginData) async {
    try {
      var body = jsonEncode(loginData.toJson());
      http.Response res = await http.post(loginUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      return res;
    } catch (e) {
      print(e.toString());
    } finally {
      print("@Login ");
      print(jsonEncode(loginData));
      //done u can do sth here
    }
  }

  static setToken(String token, String refreshToken) async {
    AuthData data = AuthData(token, refreshToken);
    return SESSION.set('tokens', data);
  }

  static getToken() async {
    return await SESSION.get('tokens');
  }
}
