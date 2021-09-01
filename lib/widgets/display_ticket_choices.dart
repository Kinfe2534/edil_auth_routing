import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';

class DisplayTicketChoices extends StatefulWidget {
  DisplayTicketChoices({Key key}) : super(key: key);

  @override
  _DisplayTicketChoicesState createState() => _DisplayTicketChoicesState();
}

class _DisplayTicketChoicesState extends State<DisplayTicketChoices> {
  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);

    return StreamBuilder<Object>(
        stream: formBloc.ticketOrder,
        builder: (context, snapshot) {
          return ListView(
            children: formBloc.ticketsTobuy
                .map((TicketOrder ticketOrder) => Column(children: <Widget>[
                      ListTile(
                        leading: Text(ticketOrder.user_id.toString()),
                        title: Text(ticketOrder.loto_numbers.toString()),
                        subtitle: Text("Cost: ${ticketOrder.cost.toString()}"),
                        trailing: RaisedButton(
                          child: Text("Buy"),
                          onPressed: () {},
                        ),
                      ),
                      Divider(color: Colors.grey),
                    ]))
                .toList(),
          );
        });
  }
}
