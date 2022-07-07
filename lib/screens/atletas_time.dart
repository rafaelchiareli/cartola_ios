import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/models/atleta.dart';
import 'package:flutter/material.dart';

import '../widgets/progress.dart';



class ListaAtletas extends StatelessWidget {
  final int clube_id;

  ListaAtletas(this.clube_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [

        ],
      ),

      body: FutureBuilder<List<Atleta>>(
        future: listarAtletas(clube_id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return Progress();
            // TODO: Handle this case.
              break;
            case ConnectionState.done:
              final List<Atleta> atletas = snapshot.data!;
              return ListView.builder(
                  itemBuilder: (context, index)  {
                    final Atleta atleta = atletas[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              atleta.foto != "" ? atleta.foto.replaceAll('FORMATO', '140x140') : 'https://png.pngtree.com/png-clipart/20190604/original/pngtree-404-error-page-png-image_1362453.jpg'),
                          backgroundColor: Colors.transparent,
                          radius: 25,// no matter how big it is, it won't overflow
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                atleta.nome
                                    ,style: TextStyle(
                                fontSize: 17
                              ),
                              ),
                            ),
                            Column(
                              children: [

                                Icon(Icons.price_change),
                                Text(atleta.minimoParaValorizar.toString())
                              ],
                            )

                          ],
                        ),
                        subtitle: Container(
                          child:
                              Row(
                                children: [

                                  atleta.icone,

                                ],
                              )

                          ),
                        ),
                      );

                  },
                itemCount: atletas.length,
              );
              break;
            case ConnectionState.active:
            // TODO: Handle this case.
              break;
          }
          return Text('Erro desconhecido');
        })

      );

  }
}
