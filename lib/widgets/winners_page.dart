import 'dart:convert';

import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/http_response_message.dart';
import 'package:edil/service/http_service.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WinnersPage extends StatefulWidget {
  final Lottery lottery;
  const WinnersPage({Key key, this.lottery}) : super(key: key);

  @override
  _WinnersPageState createState() => _WinnersPageState();
}

class _WinnersPageState extends State<WinnersPage> {
  Widget _displayWinners(
      Lottery lottery, http.Response res, FormBloc formBloc) {
    //http.Response res = await formBloc.httpService.getWinners(lottery.id);
    try {
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        Winners winners = Winners.fromJson(data);
        return Column(
          children: <Widget>[
            ListTile(
              leading: Text(lottery.id.toString()),
              title: Text("First Winner"),
              subtitle: Text("${winners.first_winner.loto_number}"),
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Text(lottery.id.toString()),
              title: Text("Second Winner"),
              subtitle: Text("${winners.second_winner.loto_number}"),
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Text(lottery.id.toString()),
              title: Text("Third Winner"),
              subtitle: Text("${winners.third_winner.loto_number}"),
            ),
            Divider(color: Colors.grey),
          ],
        );
        // formBloc.addHttpResponseMessage(data["message"]);
        //  Navigator.pop(context);
      } else if (res.statusCode == 400) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        formBloc.addHttpResponseMessage(data["message"]);
        return Container(
          width: 300,
          height: 150,
          child: HttpResponseMessage.AddHttpResponse(formBloc),
        );
        //  Navigator.pop(context);
      } else {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        formBloc.addHttpResponseMessage(" ");
        print(data['message']);
        throw Exception(data);
      }
    } catch (e) {
      print("Exception happened in all Winners");
    }
  }

  Future<http.Response> allWinners;
  @override
  void initState() {
    super.initState();

    allWinners = HttpService().getWinners(widget.lottery.id);
  }

  @override
  Widget build(BuildContext context) {
    FormBloc formBloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("All Winners"),
      ),
      body: Column(children: <Widget>[
        FutureBuilder<http.Response>(
          future: allWinners,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return _displayWinners(widget.lottery, snapShot.data, formBloc);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        Container(
          width: 300,
          height: 150,
          child: HttpResponseMessage.AddHttpResponse(formBloc),
        ),
      ]),
    );
  }
}
