// home.dart
import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  TicketOrder ticketOrder;
  List<String> allDigits = ['a', 'b', 'c', 'd', 'e'];

  /*void _submitOrder(FormBloc formBloc) {
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
  }*/
  void _submitOrder(FormBloc formBloc) {
    if (_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();

      ticketOrder = new TicketOrder(
          user_id: formBloc.userData.id,
          cost: widget.cost,
          loto_numbers: allDigits.join(),
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
              DigitField(
                allDigit: allDigits,
                index: 0,
              ),
              Divider(),
              DigitField(
                allDigit: allDigits,
                index: 1,
              ),
              Divider(),
              DigitField(
                allDigit: allDigits,
                index: 2,
              ),
              Divider(),
              DigitField(
                allDigit: allDigits,
                index: 3,
              ),
              Divider(),
              DigitField(
                allDigit: allDigits,
                index: 4,
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width / 6,
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

class DigitField extends StatelessWidget {
  // final Function fn;
  final List<String> allDigit;
  final int index;
  const DigitField({Key key, this.allDigit, this.index}) : super(key: key);

  String _validateItemRequired(String value) {
    return int.tryParse(value) == null ? "e" : null;
  }

  void _digitSaver(String value, List<String> allDigit, int index) {
    allDigit[index] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 7,
        child: TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              labelText: '<0-9>',
              hintText: "input"),
          onSaved: (value) => _digitSaver(value, allDigit, index),
          validator: _validateItemRequired,
          maxLength: 1,
        ));
  }
}
