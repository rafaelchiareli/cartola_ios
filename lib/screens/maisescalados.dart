import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/models/maisEscalados.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';
import '../widgets/pontos.dart';
import '../widgets/progress.dart';

class Destaques extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mais Escalados'),
      ),
      body: FutureBuilder<List<MaisEscalados>>(
        future: listarMaisEscalados(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              final maisEscalados = snapshot.data!;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 50 / 15,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3),
                  itemCount: maisEscalados.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final mais = maisEscalados[index];
                    final nome = (index + 1).toString() + ' - ' +  mais.atleta.nome;
                    return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Card(
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 6.0)),
                              Row(
                                children: [
                                  SizedBox(

                                    height: 110,
                                    width: 80,
                                    child: Image.network(mais.atleta.fotoUtl
                                        .replaceAll('FORMATO', '140x140')),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                   Flexible(child: Text(nome)),
                                   Flexible(child: Text(mais.posicaoAbreviada)),
                                  Text('Total de Escalações: ${mais.escalacoes}'),
                                  Expanded(child: Pontos(mais.atleta.id)),


                                  ]),

                            ],
                          ),
                        ));
                  }); // TODO: Handle this case.

              break;
          }
          return Text('Erro desconhecido');
        },
      ),
    );
  }
}
