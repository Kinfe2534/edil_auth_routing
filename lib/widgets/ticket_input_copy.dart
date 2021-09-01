// home.dart

import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/provider.dart';
import 'package:edil/widgets/confine_input.dart';
import 'package:flutter/material.dart';

class TicketInput extends StatefulWidget {
  @override
  _TicketInputState createState() => _TicketInputState();
}

class _TicketInputState extends State<TicketInput> {
  final double _borderRadius = 8;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  //order to save

  //List<TicketOrder> ticketOrders = Provider.of(context);
  TicketOrder ticketOrder = TicketOrder();
  String ticketAllDigits;
  String ticketFirstDigit;
  String ticketSecondDigit;
  String ticketThirdDigit;
  String ticketFourthDigit;
  String ticketFifthDigit;
  String _validateItemRequired(String value) {
    return value.isEmpty ? 'Item Required' : null;
  }

  String _validateItemCount(String value) {
    int _valueAsInteger = value.isEmpty ? 0 : int.tryParse(value);
    return _valueAsInteger == 0 ? 'At least one Item is Required' : null;
  }

  void _submitOrder() {
    if (_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();
      ticketAllDigits = ticketFirstDigit +
          ticketSecondDigit +
          ticketThirdDigit +
          ticketFourthDigit +
          ticketFifthDigit;
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
              ConfineInput(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: 'Espresso',
                    labelText: 'input',
                  ),
                  //validator: (value) => _validateItemRequired(value),
                  onSaved: (value) => ticketFirstDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              ConfineInput(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: '3',
                    labelText: 'input',
                  ),
                  //validator: (value) => _validateItemCount(value),
                  onSaved: (value) => ticketSecondDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              ConfineInput(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: 'Espresso',
                    labelText: 'input',
                  ),
                  //validator: (value) => _validateItemRequired(value),
                  onSaved: (value) => ticketThirdDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              ConfineInput(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: '3',
                    labelText: 'input',
                  ),
                  //validator: (value) => _validateItemCount(value),
                  onSaved: (value) => ticketFourthDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              ConfineInput(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius))),
                    //hintText: '3',
                    labelText: 'input',
                  ),
                  //validator: (value) => _validateItemCount(value),
                  onSaved: (value) => ticketFifthDigit = value,
                  validator: _validateItemRequired,
                ),
              ),
              Divider(),
              TextButton(
                child: Icon(Icons.add),
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
                onPressed: () => _submitOrder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
