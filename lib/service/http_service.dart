import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/model/lottery_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<List<Lottery>> getLotteries() async {
    final Uri allLotteriessUrl =
        Uri.parse("http://localhost:8080/api/ticket/all");

    http.Response res = await http.get(allLotteriessUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Lottery> lotteries =
          body.map((dynamic item) => Lottery.fromJson(item)).toList();
      return lotteries;
    } else {
      throw Exception("Failed to get Lotteries");
    }
  }

  Future<List<Ticket>> getAllTickets() async {
    final Uri allTicketsUrl = Uri.parse("http://localhost:8080/api/ticket/all");
    http.Response res = await http.get(allTicketsUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Ticket> tickets =
          body.map((dynamic item) => Ticket.fromJson(item)).toList();
      return tickets;
    } else {
      throw Exception("Failed to get tickets");
    }
  }

  Future<dynamic> register(SignupData signupData) async {
    final Uri signupUrl = Uri.parse("http://localhost:8080/api/auth/signup");
    var body = jsonEncode(signupData.toJson());
    http.Response res = await http.post(signupUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception("Failed to register");
    }
  }

  Future<UserData> login(LoginData loginData) async {
    final Uri loginUrl = Uri.parse("http://localhost:8080/api/auth/signin");
    var body = jsonEncode(loginData.toJson());
    http.Response res = await http.post(loginUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return UserData.fromJson(data);
    } else {
      throw Exception("Failed to Load Data");
    }
  }
}
