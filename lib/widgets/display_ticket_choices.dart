import 'dart:convert';

import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/http_response_message.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                          onPressed: () async {
                            http.Response res = await formBloc.httpService
                                .createTicket(ticketOrder);
                            try {
                              if (res.statusCode == 200) {
                                final data = jsonDecode(res.body)
                                    as Map<String, dynamic>;
                                Ticket ticket = Ticket.fromJson(data);

                                formBloc.addHttpResponseMessage(
                                    "Ticket Number :  ${ticket.loto_number}${data["message"]}");
                                Navigator.pop(context);
                              } else {
                                final data = jsonDecode(res.body)
                                    as Map<String, dynamic>;
                                formBloc.addHttpResponseMessage(
                                    "error creating lottery id ${ticketOrder.lottery_id}: loto number :${ticketOrder.loto_numbers}");
                                print(res.statusCode);
                                print(data['message']);
                                throw Exception("Esception in create lottery");
                              }
                            } catch (e) {
                              print("Exception happened in Create Lottey");
                            }
                          },
                        ),
                      ),
                      Divider(color: Colors.grey),
                    ]))
                .toList(),
          );
        });
  }
}
