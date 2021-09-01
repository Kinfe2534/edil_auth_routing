// home.dart
import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:edil/widgets/form_title.dart';

class Tickets extends StatelessWidget {
  final Lottery lottery;
  const Tickets({Key key, this.lottery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        //  FormTitle(formTitle: "Buy 5 Birr Ticket"),
        Center(child: Text("Buy 5 Birr Ticket")),
        Divider(),
        TicketInput(
          cost: 5,
          lottery: lottery,
        ),
        Divider(),
        // FormTitle(formTitle: "Buy 10 Birr Ticket"),
        Center(child: Text("Buy 10 Birr Ticket")),
        Divider(),
        TicketInput(
          cost: 10,
          lottery: lottery,
        ),
        Divider(),
        // FormTitle(formTitle: "Buy 50 Birr Ticket"),
        Center(child: Text("Buy 15 Birr Ticket")),
        Divider(),
        TicketInput(
          cost: 15,
          lottery: lottery,
        ),
        Divider(),
      ],
    );
  }
}

class TicketInput extends StatefulWidget {
  final Lottery lottery;
  final int cost;
  const TicketInput({Key key, this.cost, this.lottery}) : super(key: key);
  @override
  _TicketInputState createState() => _TicketInputState();
}

class _TicketInputState extends State<TicketInput> {
  final int _inputSizeDivider = 6;
  final int _inputSubstract = 34;
  final int _inputAdder = 0;
  final double _borderRadius = 8;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  //order to save
  TicketOrder ticketOrder;
  String ticketAllDigits;
  String ticketFirstDigit;
  String ticketSecondDigit;
  String ticketThirdDigit;
  String ticketFourthDigit;
  String ticketFifthDigit;
  static final RegExp singleDigit = RegExp(r'\b([0-9])');
  String _validateItemRequired(String value) {
    return singleDigit.hasMatch(value) ? null : "Error";
  }

  void _submitOrder(FormBloc formBloc) {
    if (_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();
      ticketAllDigits = ticketFirstDigit +
          ticketSecondDigit +
          ticketThirdDigit +
          ticketFourthDigit +
          ticketFifthDigit;
      ticketOrder = new TicketOrder(
          user_id: formBloc.userData.id,
          cost: widget.cost,
          loto_numbers: ticketAllDigits,
          lottery_id: widget.lottery.id);
      formBloc.ticketsTobuy.add(ticketOrder);
      formBloc.addTicketOrder("update");
    }
  }

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);
    return SafeArea(
      child: Form(
        key: _formStateKey,
        autovalidate: true,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: (MediaQuery.of(context).size.width - _inputSubstract) /
                    _inputSizeDivider,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: 'Espresso',
                    labelText: 'input',
                  ),
                  onSaved: (value) => ticketFirstDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              SizedBox(
                width: (MediaQuery.of(context).size.width - _inputSubstract) /
                    _inputSizeDivider,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: '3',
                    labelText: 'input',
                  ),
                  onSaved: (value) => ticketSecondDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              SizedBox(
                width: (MediaQuery.of(context).size.width - _inputSubstract) /
                    _inputSizeDivider,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: 'Espresso',
                    labelText: 'input',
                  ),
                  onSaved: (value) => ticketThirdDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              SizedBox(
                width: (MediaQuery.of(context).size.width - _inputSubstract) /
                    _inputSizeDivider,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: '3',
                    labelText: 'input',
                  ),
                  onSaved: (value) => ticketFourthDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              SizedBox(
                width: (MediaQuery.of(context).size.width - _inputSubstract) /
                    _inputSizeDivider,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: '3',
                    labelText: 'input',
                  ),
                  onSaved: (value) => ticketFifthDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              SizedBox(
                width: (MediaQuery.of(context).size.width -
                        _inputSubstract +
                        _inputAdder) /
                    _inputSizeDivider,
                child: TextButton(
                  child: Text('Add'),
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                    backgroundColor: Colors.lightGreen.shade100,
                    onSurface: Colors.pink,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontStyle: FontStyle.italic),
                  ),
                  onPressed: () => _submitOrder(formBloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
