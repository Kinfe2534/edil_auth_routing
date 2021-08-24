import 'package:edil/pages/lotteries_pages/lotteries_page.dart';
import 'package:flutter/material.dart';
import 'pages/auth_pages/forgot_password_screen.dart';

import 'pages/auth_pages/login_screen.dart';
import 'pages/auth_pages/signup_screen.dart';
import 'service/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Edil Lottery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LotteriesPageLoggedOut(),
        routes: {
          '/lotteriesPageLoggedOut': (context) => LotteriesPageLoggedOut(),
          '/lotteriesPageLoggedIn': (context) => LotteriesPageLoggedIn(),
          '/login': (context) => Login(),
          '/signup': (context) => Signup(),
          '/forgot': (context) => ForgotPassword(),
        },
      ),
    );
  }
}
