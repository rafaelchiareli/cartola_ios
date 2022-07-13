import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/models/partida.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';
import '../widgets/progress.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partidas da Rodada'),
      ),
      drawer: NavigationDrawerWidget(),
      body: FutureBuilder<List<Partida>>(
          future: listarPartidas(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                // TODO: Handle this case
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                final List<Partida> partidas = snapshot.data!;
                return ListView.builder(
                    itemCount: partidas.length,
                    itemBuilder: (context, index) {
                      final partida = partidas[index];
                      return Card(
                        child: SizedBox(
                          height: 90,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(child: Text('${partida.partidaData.toString()} - ${partida.local}',
                                  style: TextStyle(
                                    fontSize: 14
                                  ),),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('${partida.clubeCasaPosicao.toString()}°'),
                                          Image.network(partida.clubeCasa.utlEscudo),
                                        ],
                                      ),
                                      // CircleAvatar(
                                      //   backgroundImage: NetworkImage(partida.clubeCasa.utlEscudo),
                                      //   backgroundColor: Colors.transparent,
                                      //   radius: 20,
                                      // ),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      Text('X'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(partida.clubeVisita.utlEscudo),
                                          Text('${partida.clubeVisitantePosicao.toString()}°'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // CircleAvatar(
                                  //   backgroundImage: NetworkImage(partida.clubeVisita.utlEscudo),
                                  //   backgroundColor: Colors.transparent,
                                  //   radius: 20,
                                  // ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        // child: ListTile(
                        //
                        //   leading: CircleAvatar(
                        //     backgroundImage:
                        //         NetworkImage(partida.clubeCasa.utlEscudo),
                        //     backgroundColor: Colors.transparent,
                        //     radius:
                        //         25, // no matter how big it is, it won't overflow
                        //   ),
                        // ),
                      );
                    });
                break;
            }
            return Text('Erro desconhecido');
          }),
    );
  }
}
