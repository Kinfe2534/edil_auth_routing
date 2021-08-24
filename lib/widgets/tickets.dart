import 'package:flutter/cupertino.dart';
import 'package:edil/widgets/form_title.dart';
import 'package:edil/widgets/ticket_input.dart';
import 'package:flutter/material.dart';

class Tickets extends StatelessWidget {
  const Tickets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FormTitle(formTitle: "Buy 5 Birr Ticket"),
          Divider(),
          TicketInput(),
          Divider(),
          FormTitle(formTitle: "Buy 10 Birr Ticket"),
          Divider(),
          TicketInput(),
          Divider(),
          FormTitle(formTitle: "Buy 50 Birr Ticket"),
          Divider(),
          TicketInput(),
          Divider(),
        ],
      ),
    );
  }
}
