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
    return ListView(
      children: formBloc.ticketsTobuy
          .map((TicketOrder ticketOrder) => Column(children: <Widget>[
                ListTile(
                  leading: Text('''
                           "user Id " ${ticketOrder.user_id.toString()} 
                           "lottery Id " ${ticketOrder.lottery_id.toString()}
                            '''),
                  title: Text(ticketOrder.loto_numbers.toString()),
                  trailing: Icon(Icons.arrow_forward_sharp),
                  subtitle: Text("Cost: ${ticketOrder.cost.toString()}"),
                  // onTap: () =>
                  //  Navigator.of(context).push(MaterialPageRoute(
                  //  builder: (context) =>
                  // LotteryDetail(lottery: lottery))),
                  //    TicketDetail(ticket: ticket))),
                  //onTap: () async {
                  // final result = await Navigator.push<bool>(
                  //  context,
                  // MaterialPageRoute(
                  //   builder: (context) =>
                  // LotteryDetail(lottery: lottery))),
                  //     TicketDetail(ticket: ticket)));
                  // if (result == true) {
                  //  setState(() {
                  //   updateStatus = true;
                  // });
                  // }
                  //  print("update ticket: $result");
                  // }
                ),
                Divider(color: Colors.grey),
              ]))
          .toList(),
    );
  }
}
