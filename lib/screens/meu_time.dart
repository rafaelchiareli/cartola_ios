import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/widgets/navigation_drawer.dart';
import 'package:cartola_ios/widgets/progress.dart';
import 'package:flutter/material.dart';

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
                  title: Text(meuPeril.time.nome),
                ),
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
