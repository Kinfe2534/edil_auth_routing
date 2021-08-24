import 'package:edil/widgets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:edil/model/lottery_model.dart';

class BuyLottery extends StatelessWidget {
  final Lottery lottery;

  BuyLottery({@required this.lottery, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lottery.type),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt_outlined),
        onPressed: () {
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
                        subtitle: Text(lottery.lotteryCode),
                      ),
                      ListTile(
                        title: Text("Id"),
                        subtitle: Text("${lottery.id}"),
                      ),
                      ListTile(
                        title: Text("Lot Dat"),
                        subtitle: Text((lottery.lotDay).toString()),
                      ),
                      ListTile(
                        title: Text("Prize"),
                        subtitle: Text("${lottery.prize}"),
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
