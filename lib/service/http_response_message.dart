import 'package:flutter/material.dart';

import 'form_bloc.dart';

class HttpResponseMessage {
  static Widget AddHttpResponse(FormBloc bloc) {
    return StreamBuilder(
        stream: bloc.httpResponseMessage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data,
              style: TextStyle(color: Colors.red),
            );
          }
          return Text('');
        } // builder
        );
  } // widget
}// helper