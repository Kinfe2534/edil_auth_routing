import 'package:edil/service/http_service.dart';
import 'package:flutter/material.dart';

import 'package:edil/model/lottery_model.dart';

class TicketDetail extends StatelessWidget {
  final Ticket ticket;
  final HttpService httpService = HttpService();
  TicketDetail({@required this.ticket, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ticket.cost.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          await httpService.deletePost(ticket.id);
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Lottery Code"),
                  subtitle: Text(ticket.loto_number.toString()),
                ),
                ListTile(
                  title: Text("Id"),
                  subtitle: Text("${ticket.id}"),
                ),
                ListTile(
                  title: Text("Lot Dat"),
                  subtitle: Text((ticket.user.cellphone).toString()),
                ),
                ListTile(
                  title: Text("Prize"),
                  subtitle: Text("${ticket.user.email}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
