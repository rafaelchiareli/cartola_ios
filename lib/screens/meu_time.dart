import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/widgets/navigation_drawer.dart';
import 'package:cartola_ios/widgets/progress.dart';
import 'package:flutter/material.dart';

import '../models/atleta.dart';
import '../models/meu_perfil.dart';

class Perfl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Perfil>(
      future: buscarMeuPerfil(),
        builder: (context, snapshot) {
        print(buscarMeuPerfil());
        switch (snapshot.connectionState){

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
            print(snapshot.data);
            if (snapshot.hasData)
            {
              final Perfil meuPeril = snapshot.data!;

              return Scaffold(
                drawer: NavigationDrawerWidget(),
                appBar: AppBar(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(meuPeril.time.urlEscudo),
                    backgroundColor: Colors.transparent,
                    radius:
                    25, // no matter how big it is, it won't overflow
                  ),
                  title: Text(meuPeril.time.nome, style: TextStyle(
                    fontSize: 14,
                  ),),
                ),
                body: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: meuPeril.atletas.length,
                          itemBuilder: (context, index){
                            final Atleta atleta =  meuPeril.atletas[index];
                            return Card(
                              child: Flexible(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(atleta.foto != ""
                                        ? atleta.foto.replaceAll('FORMATO', '140x140')
                                        : 'https://png.pngtree.com/png-clipart/20190604/original/pngtree-404-error-page-png-image_1362453.jpg'),
                                    backgroundColor: Colors.transparent,
                                    radius:
                                    25, // no matter how big it is, it won't overflow
                                  ),
                                  title: Text(atleta.nome),
                                ),
                              ),
                            );

                          }
                      ),
                    )
                  ],
                )
              );

            }
            else{
              return Text('Sem dados');
            }


            break;
        }
        return Text('Erro ao carregar');
        }
    );
  }
}
