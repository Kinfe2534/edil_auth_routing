import 'dart:convert';

import 'package:edil/model/lottery_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final Uri lotteriesUrl = Uri.parse("http://localhost:8080/api/lottery/all");
  Future<void> deletePost(int id) async {
    var res = await http.delete(Uri.parse("$lotteriesUrl/$id"));
    if (res.statusCode == 200) {
      print("Deleted");
    }
  }

  Future<List<Lottery>> getLotteries() async {
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
}
