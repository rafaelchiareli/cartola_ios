import 'package:cartola_ios/screens/maisescalados.dart';
import 'package:cartola_ios/screens/meu_time.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/times.dart';

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 115,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    //  color: Colors.blue,

                    ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    //  color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.sports_soccer_sharp),
                title: Text('Times'),
                onTap: () {
                  _showTimes(context);
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.pop(context);
                  // });
                }),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Mais Escalados'),
              onTap: () {
                _showMaisEscalados(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_off),
              title: Text('Meu Time'),
              onTap: () => {_showPerfil(context)},
            ),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Paginal Inicial'),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
                }),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Fechar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTimes(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Times(),
    ));
  }

  void _showPerfil(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Perfl(),
    ));
  }

  void _showMaisEscalados(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Destaques(),
    ));
  }
}
