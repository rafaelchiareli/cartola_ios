import 'package:cartola_ios/models/atleta_resumido.dart';

import 'atleta.dart';

class MaisEscalados{



  final String posicao;
  final String posicaoAbreviada;
  final String clube;
  final String urlClube;
  final int clubeId;
  final int escalacoes;
  final AtletaResumido atleta;
  final String clubeNome;

  MaisEscalados.name(
      this.posicao,
      this.posicaoAbreviada,
      this.clube,
      this.urlClube,
      this.clubeId,
      this.escalacoes,
      this.atleta,
      this.clubeNome);



  @override
  String toString() {
    return 'MaisEscalados{posicao: $posicao, posicaoAbreviada: $posicaoAbreviada, clube: $clube, urlClube: $urlClube, clubeId: $clubeId, escalacoes: $escalacoes, atleta: $atleta, clubeNome: $clubeNome}';
  }

  
}

