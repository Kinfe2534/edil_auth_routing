import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/http_response_message.dart';
import 'package:edil/service/provider.dart';
import 'package:edil/widgets/display_ticket_choices.dart';
import 'package:edil/widgets/ticket_input.dart';

import 'package:flutter/material.dart';
import 'package:edil/model/lottery_model.dart';

class BuyLottery extends StatefulWidget {
  final Lottery lottery;

  const BuyLottery({@required this.lottery, Key key}) : super(key: key);

  @override
  _BuyLotteryState createState() => _BuyLotteryState();
}

class _BuyLotteryState extends State<BuyLottery> {
  final bool updateStatus = false;
  @override
  Widget build(BuildContext context) {
    FormBloc formBloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lottery.type),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context, updateStatus);
          print('working');
        },
      ),
      body: ListView(children: <Widget>[
        ListTile(
          leading: Text(widget.lottery.id.toString()),
          title: Text(widget.lottery.type),
          trailing: Icon(Icons.arrow_forward_sharp),
          subtitle: Text(widget.lottery.prize.toString()),
        ),
        Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Tickets(
              lottery: widget.lottery,
            )),
        Container(
          width: 300,
          height: 100,
          child: Padding(
              padding: EdgeInsets.all(22),
              child: HttpResponseMessage.AddHttpResponse(formBloc)),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            child: DisplayTicketChoices()),
        Divider(color: Colors.grey),
      ]),
      //single chiled scrolll view
    ); //sca
  }
}
