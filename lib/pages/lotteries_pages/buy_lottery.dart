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
            height: MediaQuery.of(context).size.height,
            child: DisplayTicketChoices()),
      ]),
      //single chiled scrolll view
    ); //sca
  }
}
