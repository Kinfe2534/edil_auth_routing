// home.dart
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
  Order _order = Order();
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
      print('Order Item: ${_order.item}');
      print('Order Quantity: ${_order.quantity}');
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
                  onSaved: (value) => _order.item = value,
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
                  onSaved: (value) => _order.quantity = int.tryParse(value),
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
                  //validator: (value) => _validateItemRequired(value),
                  onSaved: (value) => _order.item = value,
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
                  onSaved: (value) => _order.quantity = int.tryParse(value),
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
                  onSaved: (value) => _order.quantity = int.tryParse(value),
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

class Order {
  String item;
  int quantity;
}
