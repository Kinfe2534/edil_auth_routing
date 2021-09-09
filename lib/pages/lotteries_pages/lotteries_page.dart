import 'dart:async';
import 'package:edil/pages/lotteries_pages/buy_lottery.dart';
import 'package:edil/pages/lotteries_pages/ticket_detail.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/http_service.dart';
import 'package:edil/service/provider.dart';
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

    allLotteries = HttpService().getAllLotteries();
  }

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);
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

            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: lotteries.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Text(lotteries[index].id.toString()),
                      title: Text(lotteries[index].type.toString()),
                      trailing: Icon(Icons.arrow_forward_sharp),
                      subtitle: Text(lotteries[index].id.toString()),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                // LotteryDetail(lottery: lottery))),
                                BuyLottery(lottery: lotteries[index])));
                      });
                });
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
    allLotteries = HttpService().getAllLotteries();
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
      body: ListView(
        children: <Widget>[
          Divider(),
          Center(child: Text("Available Lotteries")),
          Divider(),
          Container(
              height: MediaQuery.of(context).size.height / 1,
              child: LotteryList(allLotteries: allLotteries)),
          Divider(),
          Center(child: Text("Your Tickets")),
          Divider(),
          Container(
              height: MediaQuery.of(context).size.height / .8,
              child: TicketList(allTickets: allTickets)),
        ],
      ),
    );
  }
}

class LotteryList extends StatefulWidget {
  final Future<List<Lottery>> allLotteries;

  LotteryList({
    Key key,
    @required this.allLotteries,
  }) : super(key: key);

  @override
  _LotteryListState createState() => _LotteryListState();
}

class _LotteryListState extends State<LotteryList> {
  bool updateStatus = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Lottery>>(
        future: widget.allLotteries,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Lottery> lotteries = snapShot.data;

            return ListView(
              children: lotteries
                  .map((Lottery lottery) => Column(children: <Widget>[
                        ListTile(
                          leading: Text(lottery.id.toString()),
                          title: Text(lottery.type),
                          trailing: Icon(Icons.arrow_forward_sharp),
                          subtitle: Text(lottery.id.toString()),
                          // onTap: () async{
                          // final result= await   Navigator.of(context).push(MaterialPageRoute(
                          //  builder: (context) =>
                          // LotteryDetail(lottery: lottery))),
                          //  BuyLottery(lottery: lottery)));},
                          onTap: () async {
                            final result = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        // LotteryDetail(lottery: lottery))),
                                        BuyLottery(lottery: lottery)));
                            if (result == true) {
                              setState(() {
                                updateStatus = true;
                              });
                            }
                            print("update lottery : $result");
                          },
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

class TicketList extends StatefulWidget {
  final Future<List<Ticket>> allTickets;

  TicketList({
    Key key,
    @required this.allTickets,
  }) : super(key: key);

  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  bool updateStatus = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Ticket>>(
        future: widget.allTickets,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Ticket> tickets = snapShot.data;

            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: tickets.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Text(tickets[index].id.toString()),
                      title: Text(tickets[index].loto_number.toString()),
                      trailing: Icon(Icons.arrow_forward_sharp),
                      subtitle: Text("Cost: ${tickets[index].cost.toString()}"),
                      onTap: () async {
                        final result = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // LotteryDetail(lottery: lottery))),
                                    TicketDetail(ticket: tickets[index])));
                        if (result == true) {
                          setState(() {
                            updateStatus = true;
                          });
                        }
                        print("update ticket: $result");
                      });
                });
          } else if (snapShot.hasError) {
            return Center(child: Text('Has Error'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
