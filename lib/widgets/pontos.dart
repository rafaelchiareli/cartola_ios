import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/widgets/progress.dart';
import 'package:flutter/material.dart';

class Pontos extends StatelessWidget {
  final int atletaId;

  Pontos(this.atletaId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: pontuacaoNaRodada(atletaId),
        builder: (context, snapshot ) {
          switch (snapshot.connectionState){
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
            //  return Progress();
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              final pontos = snapshot.data ?? 0;
              return Text(
                pontos.toString()
              );
              break;
          }
          return Text('Erro desconhecido');
        }
    );
  }
}
