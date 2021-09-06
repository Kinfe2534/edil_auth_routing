import 'package:edil/pages/auth_pages/login_screen.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:edil/pages/drawer_pages/getAllWinners.dart';
import 'package:edil/pages/drawer_pages/draw.dart';
import 'package:edil/pages/drawer_pages/updateLottery.dart';

class MenuListTileLoggedOutWidget extends StatefulWidget {
  const MenuListTileLoggedOutWidget({Key key}) : super(key: key);

  @override
  _MenuListTileLoggedOutWidgetState createState() =>
      _MenuListTileLoggedOutWidgetState();
}

class _MenuListTileLoggedOutWidgetState
    extends State<MenuListTileLoggedOutWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.cake),
          title: Text('Get All Winners'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GetAllWinners(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.sentiment_satisfied),
          title: Text('Draw'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Draw(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.alarm),
          title: Text('Update Lottery'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateLottery(),
              ),
            );
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(Icons.alarm),
          title: Text('Login'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class MenuListTileLoggedInWidget extends StatefulWidget {
  const MenuListTileLoggedInWidget({Key key}) : super(key: key);

  @override
  _MenuListTileLoggedInWidgetState createState() =>
      _MenuListTileLoggedInWidgetState();
}

class _MenuListTileLoggedInWidgetState
    extends State<MenuListTileLoggedInWidget> {
  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.cake),
          title: Text('Get All Winners'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GetAllWinners(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.sentiment_satisfied),
          title: Text('Draw'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Draw(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.alarm),
          title: Text('Update Lottery'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateLottery(),
              ),
            );
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(Icons.alarm),
          title: Text('Logout'),
          onTap: () {
            formBloc.userData = null;
            Navigator.pushNamed(context, "/lotteriesPageLoggedOut");
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
