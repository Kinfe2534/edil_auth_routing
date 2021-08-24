import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:edil/widgets/menu_list_tile.dart';

class LeftDrawerLoggedOutWidget extends StatelessWidget {
  const LeftDrawerLoggedOutWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(
              Icons.face,
              size: 48.0,
              color: Colors.white,
            ),
            accountName: Text('Sandy Smith'),
            accountEmail: Text('sandy.smith@domainname.com'),
            otherAccountsPictures: <Widget>[
              Icon(
                Icons.bookmark_border,
                color: Colors.white,
              )
            ],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/coding_desk.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const MenuListTileLoggedOutWidget(),
        ],
      ),
    );
  }
}

class LeftDrawerLoggedInWidget extends StatelessWidget {
  const LeftDrawerLoggedInWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = Provider.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(
              Icons.face,
              size: 48.0,
              color: Colors.blue,
            ),
            accountName: Text(
              formBloc.userData.username,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.deepPurple,
                decoration: TextDecoration.underline,
                decorationColor: Colors.deepPurpleAccent,
                decorationStyle: TextDecorationStyle.dotted,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            accountEmail: Text(
              formBloc.userData.email,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.deepPurple,
                decoration: TextDecoration.underline,
                decorationColor: Colors.deepPurpleAccent,
                decorationStyle: TextDecorationStyle.dotted,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            otherAccountsPictures: <Widget>[
              Icon(
                Icons.bookmark_border,
                color: Colors.red,
              )
            ],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/coding_desk.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const MenuListTileLoggedInWidget(),
        ],
      ),
    );
  }
}
