//import 'dart:js';

import 'package:flutter/material.dart';
import 'form_bloc.dart';

class Provider extends InheritedWidget {
  final bloc = FormBloc();
  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static FormBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).bloc;
  }
}
