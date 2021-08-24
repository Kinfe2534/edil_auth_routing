import 'package:flutter/material.dart';

class ConfineInput extends StatelessWidget {
  const ConfineInput({Key key, this.child}) : super(key: key);
  final Widget child;
  final int _inputSizeDivider = 6;
  final int _inputSubstract = 34;
  final int _inputAdder = 10;
  final double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - _inputSubstract) /
          _inputSizeDivider,
      child: Padding(padding: EdgeInsets.all(16.0), child: child),
    );
  }
}
