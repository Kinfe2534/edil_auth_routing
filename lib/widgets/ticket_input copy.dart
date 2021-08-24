// home.dart
import 'package:edil/model/ticket_model.dart';
import 'package:flutter/material.dart';

class TicketInput extends StatefulWidget {
  @override
  _TicketInputState createState() => _TicketInputState();
}

class _TicketInputState extends State<TicketInput> {
  final int _inputSizeDivider = 6;
  final int _inputSubstract = 34;
  final int _inputAdder = 10;
  final double _borderRadius = 8;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  //order to save
  Ticket ticketOrder = Ticket();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formStateKey,
        autovalidate: true,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius))),
                  //hintText: 'Espresso',
                  labelText: 'input',
                ),
                //validator: (value) => _validateItemRequired(value),
                onSaved: (value) => ticketOrder.loto_numbers[0] = value,
                validator: _validateItemRequired,
              ),
              Divider(),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius))),
                  //hintText: '3',
                  labelText: 'input',
                ),
                //validator: (value) => _validateItemCount(value),
                onSaved: (value) => ticketOrder.loto_numbers[1] = value,
                validator: _validateItemRequired,
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
                  //validator: (value) => _validateItemRequired(value),
                  onSaved: (value) => ticketOrder.loto_numbers[2] = value,
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
                  //validator: (value) => _validateItemCount(value),
                  onSaved: (value) => ticketOrder.loto_numbers[3] = value,
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
                  //validator: (value) => _validateItemCount(value),
                  onSaved: (value) => ticketOrder.loto_numbers[4] = value,
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
                  child: Text('Buy'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
