import 'package:edil/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:edil/model/lottery_model.dart';

class TicketDetail extends StatefulWidget {
  final Ticket ticket;
  final HttpService httpService = HttpService();
  TicketDetail({@required this.ticket, Key key}) : super(key: key);

  @override
  _TicketDetailState createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  final bool updateStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Details"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context, updateStatus);
          print('working');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Ticket Number"),
                  subtitle: Text(widget.ticket.loto_number.toString()),
                ),
                ListTile(
                  title: Text("Id"),
                  subtitle: Text("${widget.ticket.id}"),
                ),
                ListTile(
                  title: Text("User Cellphone"),
                  subtitle: Text((widget.ticket.user.cellphone).toString()),
                ),
                ListTile(
                  title: Text("Email"),
                  subtitle: Text("${widget.ticket.user.email}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
