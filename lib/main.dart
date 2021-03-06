import 'package:cartola_ios/screens/times.dart';
import 'package:cartola_ios/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'http/webclient.dart';
import 'models/clube.dart';
import 'screens/home.dart';
import 'widgets/progress.dart';

import 'theme/color_scheme.dart';

void main() {
  runApp(MyApp());
  //listarAtletas(262).then((listaAtletas) => print('Clubes ${listaAtletas}'));
  //listarPartidas().then((listPartidas) => print('Partidas : ${listPartidas}'));
  //listarMaisEscalados().then((mais) => print(mais));
 // pontuacaoNaRodada(37281).then((info) => print(info));
 buscarMeuPerfil().then((perfil) => print(perfil));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,

        ),
        home: WillPopScope(
          onWillPop: () async {
            //print('');
            return false;
          },
          child: Scaffold(



            body: Home(),
    ),
        ));
  }

}
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//
//
//     Text(
//       'Index 1: Business',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       if(index ==0){
//         _showTimes(context);
//       }
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cartola INB'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Business',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'School',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
//   void _showTimes(BuildContext context) {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => Times(),
//     ));
//   }
//
// }
