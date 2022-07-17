import 'atleta.dart';
import 'meu_time.dart';

class Perfil{

  final List<Atleta> atletas;
  final List<Atleta> reservas;
  final MeuTime time;
  final double pontosCampeonato;
  final double pontosUltimaRodada;
  final int esquemaId;
  final int rodadaAtual;
  final double patrimonio;
  final double valorTime;
  final int totalLigas;
  final double variacaoPatrimonio;
  final double variacaoPontos;

  Perfil(
      this.atletas,
      this.reservas,
      this.time,
      this.pontosCampeonato,
      this.pontosUltimaRodada,
      this.esquemaId,
      this.rodadaAtual,
      this.patrimonio,
      this.valorTime,
      this.totalLigas,
      this.variacaoPatrimonio,
      this.variacaoPontos);
}