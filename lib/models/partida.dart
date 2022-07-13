import 'clube.dart';

class Partida {
  final int? partidaId;
  final int? clubeCasaId;
  final int? clubeCasaPosicao;
  final int? clubeVisitanteId;
  final List<String>? aproveitamentoMandante;
  final List<String>? aproveitamentoVisitante;
  final int? clubeVisitantePosicao;
  final String? partidaData;
  final int? timestamp;
  final String? local;
  final bool? valida;
  final Clube clubeCasa;
  final Clube clubeVisita;
  Partida(
      this.partidaId,
      this.clubeCasaId,
      this.clubeCasaPosicao,
      this.clubeVisitanteId,
      this.aproveitamentoMandante,
      this.aproveitamentoVisitante,
      this.clubeVisitantePosicao,
      this.partidaData,
      this.timestamp,
      this.local,
      this.valida,
       this.clubeCasa,
      this.clubeVisita);

  @override
  String toString() {
    return 'Partida{partidaId: $partidaId, clubeCasaId: $clubeCasaId, clubeCasaPosicao: $clubeCasaPosicao, clubeVisitanteId: $clubeVisitanteId, aproveitamentoMandante: $aproveitamentoMandante, aproveitamentoVisitante: $aproveitamentoVisitante, clubeVisitantePosicao: $clubeVisitantePosicao, partidaData: $partidaData, timestamp: $timestamp, local: $local, valida: $valida, clubeCasa: $clubeCasa, clubeVisita: $clubeVisita}';
  }
}
