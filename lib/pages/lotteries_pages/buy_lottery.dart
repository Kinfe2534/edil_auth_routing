import 'package:edil/widgets/tickets.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Lottery Code"),
                        subtitle: Text(widget.lottery.lotteryCode),
                      ),
                      ListTile(
                        title: Text("Id"),
                        subtitle: Text("${widget.lottery.id}"),
                      ),
                      ListTile(
                        title: Text("Lot Dat"),
                        subtitle: Text((widget.lottery.lotDay).toString()),
                      ),
                      ListTile(
                        title: Text("Prize"),
                        subtitle: Text("${widget.lottery.prize}"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Tickets(),
          ],
        ),
      ), //single chiled scrolll view
    ); //sca
  }
}
