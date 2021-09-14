import 'dart:convert';

import 'package:edil/model/auth_model.dart';
import 'package:edil/model/lottery_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<List<Lottery>> getAllLotteries() async {
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

  Future<http.Response> register(SignupData signupData) async {
    final Uri signupUrl = Uri.parse("http://localhost:8080/api/auth/signup");
    var body = jsonEncode(signupData.toJson());
    http.Response res = await http.post(signupUrl,
        headers: {"Content-Type": "application/json"}, body: body);
    return res;
  }

  Future<http.Response> login(LoginData loginData) async {
    final Uri loginUrl = Uri.parse("http://localhost:8080/api/auth/signin");
    var body = jsonEncode(loginData.toJson());

    http.Response res = await http.post(loginUrl,
        headers: {"Content-Type": "application/json"}, body: body);
    return res;
  }

  Future<http.Response> createTicket(TicketOrder ticketOrder) async {
    final Uri createTicketUrl =
        Uri.parse("http://localhost:8080/api/ticket/create");
    var body = jsonEncode(ticketOrder.toJson());

    http.Response res = await http.post(createTicketUrl,
        headers: {"Content-Type": "application/json"}, body: body);
    return res;
  }

  Future<http.Response> createLottery(CreateLotteryModel createLottery) async {
    final Uri createLotteryUrl =
        Uri.parse("http://localhost:8080/api/lottery/create");
    var body = jsonEncode(createLottery.toJson());

    http.Response res = await http.post(createLotteryUrl,
        headers: {"Content-Type": "application/json"}, body: body);
    return res;
  }

  Future<http.Response> getWinners(int id) async {
    final Uri getWinnersUrl =
        Uri.parse("http://localhost:8080/api/lottery/getwinners?id=$id");
    http.Response res = await http.get(getWinnersUrl);

    return res;
  }

  Future<http.Response> draw(int id) async {
    final Uri drawUrl =
        Uri.parse("http://localhost:8080/api/lottery/draw?id=$id");
    http.Response res = await http.get(drawUrl);

    return res;
  }

  Future<http.Response> updateLottery(UpdateLotteryModel updateLottery) async {
    final Uri updateLotteryUrl =
        Uri.parse("http://localhost:8080/api/lottery/update");
    var body = jsonEncode(updateLottery.toJson());
    http.Response res = await http.put(updateLotteryUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    return res;
  }
}
