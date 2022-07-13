import 'dart:convert';

import 'package:cartola_ios/models/atleta.dart';
import 'package:cartola_ios/models/scout.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';
import '../models/clube.dart';
import '../models/partida.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // print('Request');
    // print('header: ${data.headers}');
    // print('body: ${data.body}');
    // print('url: ${data.baseUrl}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // print('Response');
    // print('status: ${data.statusCode}');
    // print('headers: ${data.headers}');
    // print('body: ${data.body}');
    return data;
  }
}

Future<List<Partida>> listarPartidas() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response =
      await client.get(Uri.parse('https://api.cartola.globo.com/partidas'));
  //print(response.body);
  final Map<String, dynamic> decodedJson = json.decode(response.body);
  final List<Partida> listaPartidas = [];
  final List<Clube> listaClube = await listarClubes();
  for (Map<String, dynamic> data in decodedJson["partidas"]) {

    final Partida partida = Partida(
      data['partida_id'],
      data['clube_casa_id'],
      data['clube_casa_posicao'],
      data['clube_visitante_id'],
     data['aproveitamento_mandante'].cast<String>(),
      data['aproveitamento_mandante'].cast<String>(),
     // data[' data['aproveitamento_mandante'] as List<String>,'][''],
      data['clube_visitante_posicao'],
      data['partida_data'],
      data['timestamp'],
      data['local'],
      data['valida'],
      listaClube.firstWhere((clube) => clube.id == data['clube_casa_id']),
      listaClube.firstWhere((clube2) => clube2.id == data['clube_visitante_id']),
    );
    listaPartidas.add(partida);
  }

  return listaPartidas;
}

Future<List<Clube>> listarClubes() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client
      .get(Uri.parse('https://api.cartola.globo.com/atletas/mercado'));
  //print(response.body);
  final Map<String, dynamic> decodedJson = json.decode(response.body);
  final List<Clube> listaClubes = [];
  Map data = decodedJson["clubes"];
  for (var v in data.values) {
    //print('Time ${v}');
    final Clube clubeNovo = Clube(
      v['id'],
      v['nome'],
      v['abreviacao'],
      v['escudos']['45x45'],
    );
    listaClubes.add(clubeNovo);
  }
  return listaClubes;
}

Future<List<Atleta>> listarAtletas(int clube_id) async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(
      Uri.parse('https://api.cartola.globo.com/atletas/mercado/${clube_id}'));
  final Map<String, dynamic> decodedJson = json.decode(response.body);
  final List<Atleta> listaAtletas = [];

  for (Map<String, dynamic> data in decodedJson["atletas"]) {
    print(data['scout']['CA']);
    Icon icone = Icon(Icons.add);

    switch (data['status_id']) {
      case 2:
        icone = Icon(Icons.question_mark, color: Colors.yellow);

        break;
      case 3:
        icone = Icon(Icons.cancel, color: Colors.red);
        break;
      case 5:
        icone = Icon(Icons.local_hospital, color: Colors.red);

        break;
      case 6:
        icone = Icon(Icons.notifications_none, color: Colors.black);
        break;
      case 7:
        icone = Icon(Icons.check, color: Colors.green);
        break;
    }
    final Scout scout = Scout(
      data['scout']['CA'],
      data['scout']['DS'],
      data['scout']['FC'],
      data['scout']['FF'],
      data['scout']['FS'],
      data['scout']['PI'],
      data['scout']['SG'],
      data['scout']['A'],
      data['scout']['FD'],
      data['scout']['FT'],
      data['scout']['G'],
      data['scout']['I'],
      data['scout']['PS'],
      data['scout']['DE'],
      data['scout']['GS'],
      data['scout']['PC'],
      data['scout']['VC'],
      data['scout']['GC'],
      data['scout']['PP'],
      data['scout']['DP'],
    );
    final Atleta atleta = Atleta(
        scout,
        data['atleta_id'],
        data['rodada_id'],
        data['clube_id'],
        data['posicao_id'],
        data['status_id'],
        double.parse(data['pontos_num'].toString()),
        double.parse(data['preco_num'].toString()),
        double.parse(data['variacao_num'].toString()),
        double.parse(data['media_num'].toString()),
        data['jogos_num'],
        double.parse(data['minimo_para_valorizar'].toString()),
        data['slug'],
        data['apelido'],
        data['apelido_abreviado'],
        data['nome'],
        data['foto'] == null ? "" : data['foto'],
        icone);
    listaAtletas.add(atleta);
  }

  return listaAtletas;
}
