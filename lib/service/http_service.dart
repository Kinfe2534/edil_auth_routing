import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/model/lottery_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<List<Lottery>> getLotteries() async {
    final Uri allLotteriessUrl =
        Uri.parse("http://localhost:8080/api/lottery/all");

    http.Response res = await http.get(allLotteriessUrl);
    try {
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<Lottery> lotteries =
            body.map((dynamic item) => Lottery.fromJson(item)).toList();
        return lotteries;
      } else {
        throw Exception("Failed to get Lotteries");
      }
    } catch (e) {
      print("Exception happened in  get all lotteries");
    }
  }

  Future<List<Ticket>> getAllTickets() async {
    final Uri allTicketsUrl = Uri.parse("http://localhost:8080/api/ticket/all");
    http.Response res = await http.get(allTicketsUrl);
    try {
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);

        List<Ticket> tickets =
            body.map((dynamic item) => Ticket.fromJson(item)).toList();
        return tickets;
      } else {
        throw Exception("Failed to get tickets");
      }
    } catch (e) {
      print('Exception happended in get all Tickets');
    }
  }

  Future<dynamic> register(SignupData signupData) async {
    final Uri signupUrl = Uri.parse("http://localhost:8080/api/auth/signup");
    var body = jsonEncode(signupData.toJson());
    http.Response res = await http.post(signupUrl,
        headers: {"Content-Type": "application/json"}, body: body);
    try {
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        return data;
      } else {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        print(data['message']);
        throw Exception(data);
      }
    } catch (e) {
      print("Exception happened in register");
    }
  }

  Future<dynamic> login(LoginData loginData) async {
    final Uri loginUrl = Uri.parse("http://localhost:8080/api/auth/signin");
    var body = jsonEncode(loginData.toJson());
    http.Response res = await http.post(loginUrl,
        headers: {"Content-Type": "application/json"}, body: body);
    try {
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        return UserData.fromJson(data);
      } else if (res.statusCode != 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        return data;
      }
      {
        final data = jsonDecode(res.body) as Map<String, dynamic>;

        print(res.statusCode);
        print(data['message']);
        throw Exception("Failed to login");
      }
    } catch (e) {
      print("Exception happened in login");
    }
  }
}
