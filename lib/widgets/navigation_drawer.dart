import 'package:flutter/material.dart';

import '../screens/times.dart';

class NavigationDrawerWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(

      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            SizedBox(
              height: 115,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,

                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.sports_soccer_sharp),
                title: Text('Times'),
                onTap: ( ) {
                  _showTimes(context);
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.pop(context);
                  // });


                }
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
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
}
