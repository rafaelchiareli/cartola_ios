import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/models/partida.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/navigation_drawer.dart';
import '../widgets/progress.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


String numRodada = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${numRodada}' ,
          style: TextStyle(fontSize: 20,

        ),),
        centerTitle: true,


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


                return
                    ListView.builder(
                        itemCount: partidas.length,
                        itemBuilder: (context, index) {
                          final partida = partidas[index];
                          return Card(
                            child: SizedBox(
                              height:90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(partida.partidaData!))} - ${partida.local}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [

                                          Text(partida.aproveitamentoMandante.join(','))

                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                  '${partida.clubeCasaPosicao.toString()}°'),
                                              Image.network(
                                                partida.clubeCasa.utlEscudo,
                                                width: 50,
                                                height: 50,
                                              ),
                                            ],
                                          ),
                                          // CircleAvatar(
                                          //   backgroundImage: NetworkImage(partida.clubeCasa.utlEscudo),
                                          //   backgroundColor: Colors.transparent,
                                          //   radius: 20,
                                          // ),
                                        ],
                                      ),

                                      Padding(padding: EdgeInsets.only(right: 3)),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('X'),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 6)),
                                      Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                partida.clubeVisita.utlEscudo,
                                                width: 50,
                                                height: 50,
                                              ),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 6)),
                                              Text(
                                                  '${partida.clubeVisitantePosicao.toString()}°'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [

                                          Column(
                                            children: [

                                              Text(partida.aproveitamentoMandante.join(','))

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
  void _UpdateText(texto) {
    setState(() {
       numRodada = texto;
    });
  }
}
