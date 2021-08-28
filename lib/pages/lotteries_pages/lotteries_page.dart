import 'dart:async';
import 'package:edil/pages/lotteries_pages/buy_lottery.dart';
import 'package:edil/pages/lotteries_pages/ticket_detail.dart';
import 'package:edil/service/http_service.dart';
import 'package:edil/widgets/left_drawer.dart';
import 'package:edil/widgets/right_drawer.dart';
import 'package:flutter/material.dart';
import 'package:edil/model/lottery_model.dart';

class LotteriesPageLoggedOut extends StatefulWidget {
  const LotteriesPageLoggedOut({Key key}) : super(key: key);

  @override
  _LotteriesPageLoggedOutState createState() => _LotteriesPageLoggedOutState();
}

class _LotteriesPageLoggedOutState extends State<LotteriesPageLoggedOut> {
  Future<List<Lottery>> allLotteries;

  @override
  void initState() {
    super.initState();
    allLotteries = HttpService().getLotteries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Lotteries'),
      ),
      drawer: LeftDrawerLoggedOutWidget(),
      endDrawer: RightDrawerWidget(),
      body: FutureBuilder<List<Lottery>>(
        future: allLotteries,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Lottery> lotteries = snapShot.data;

            return ListView(
              children: lotteries
                  .map((Lottery lottery) => Column(children: <Widget>[
                        ListTile(
                          leading: Text(lottery.id.toString()),
                          title: Text(lottery.type),
                          trailing: Icon(Icons.forward_10_rounded),
                          subtitle: Text(lottery.id.toString()),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      // LotteryDetail(lottery: lottery))),
                                      BuyLottery(lottery: lottery))),
                        ),
                        Divider(color: Colors.grey),
                      ]))
                  .toList(),
            );
          } else if (snapShot.hasError) {
            return Center(child: Text('Has Error'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class LotteriesPageLoggedIn extends StatefulWidget {
  const LotteriesPageLoggedIn({Key key}) : super(key: key);

  @override
  _LotteriesPageLoggedInState createState() => _LotteriesPageLoggedInState();
}

class _LotteriesPageLoggedInState extends State<LotteriesPageLoggedIn> {
  Future<List<Lottery>> allLotteries;
  Future<List<Ticket>> allTickets;
  @override
  void initState() {
    super.initState();
    allLotteries = HttpService().getLotteries();
    allTickets = HttpService().getAllTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Lotteries'),
      ),
      drawer: LeftDrawerLoggedInWidget(),
      endDrawer: RightDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Lottery>>(
              future: allLotteries,
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  List<Lottery> lotteries = snapShot.data;

                  return ListView(
                    children: lotteries
                        .map((Lottery lottery) => Column(children: <Widget>[
                              ListTile(
                                leading: Text(lottery.id.toString()),
                                title: Text(lottery.type),
                                trailing: Icon(Icons.forward_10_rounded),
                                subtitle: Text(lottery.id.toString()),
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) =>
                                            // LotteryDetail(lottery: lottery))),
                                            BuyLottery(lottery: lottery))),
                              ),
                              Divider(color: Colors.grey),
                            ]))
                        .toList(),
                  );
                } else if (snapShot.hasError) {
                  return Center(child: Text('Has Error'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            FutureBuilder<List<Ticket>>(
              future: allTickets,
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  List<Ticket> tickets = snapShot.data;

                  return ListView(
                    children: tickets
                        .map((Ticket ticket) => Column(children: <Widget>[
                              ListTile(
                                leading: Text(ticket.id.toString()),
                                title: Text(ticket.ticket_number),
                                trailing: Icon(Icons.forward_10_rounded),
                                subtitle: Text(ticket.cost.toString()),
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) =>
                                            // LotteryDetail(lottery: lottery))),
                                            TicketDetail(ticket: ticket))),
                              ),
                              Divider(color: Colors.grey),
                            ]))
                        .toList(),
                  );
                } else if (snapShot.hasError) {
                  return Center(child: Text('Has Error'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
