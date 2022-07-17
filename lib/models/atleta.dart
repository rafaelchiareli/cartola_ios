

import 'package:flutter/material.dart';

import 'scout.dart';

class Atleta{
  final Scout? scout;
  final int? atletaId;
  final int? rodadaId;
  final int? clubeId;
  final int? posicaoId;
  final int? statusId;
  final double? pontosNum;
  final double? precoNum;
  final double? variacaoNum;
  final double? mediaNum;
  final int? jogosNum;
  final double? minimoParaValorizar;
  final String? slug;
  final String? apelido;
  final String? apelidoAbreviado;
  final String nome;
  final String foto;
  final Icon icone;

  Atleta(
      this.scout,
      this.atletaId,
      this.rodadaId,
      this.clubeId,
      this.posicaoId,
      this.statusId,
      this.pontosNum,
      this.precoNum,
      this.variacaoNum,
      this.mediaNum,
      this.jogosNum,
      this.minimoParaValorizar,
      this.slug,
      this.apelido,
      this.apelidoAbreviado,
      this.nome,
      this.foto,
      this.icone);

  @override
  String toString() {
    return 'Atleta{atletaId: $atletaId, rodadaId: $rodadaId, clubeId: $clubeId, posicaoId: $posicaoId, statusId: $statusId, pontosNum: $pontosNum, precoNum: $precoNum, variacaoNum: $variacaoNum, mediaNum: $mediaNum, jogosNum: $jogosNum, minimoParaValorizar: $minimoParaValorizar, slug: $slug, apelido: $apelido, apelidoAbreviado: $apelidoAbreviado, nome: $nome, foto: $foto, icone: $icone}';
  }


}