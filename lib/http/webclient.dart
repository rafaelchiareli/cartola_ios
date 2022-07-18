import 'dart:convert';

import 'package:cartola_ios/models/atleta.dart';
import 'package:cartola_ios/models/atleta_resumido.dart';
import 'package:cartola_ios/models/maisEscalados.dart';
import 'package:cartola_ios/models/meu_perfil.dart';
import 'package:cartola_ios/models/meu_time.dart';
import 'package:cartola_ios/models/scout.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';
import '../models/clube.dart';
import '../models/partida.dart';
import '../models/rodada.dart';

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

Future<Rodada> selecionaRodada() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(
      Uri.parse('https://api.cartola.globo.com/partidas'));
  final Map<String, dynamic> decodedJson = json.decode(response.body);
  Rodada rodada = Rodada(
      decodedJson['rodada']  );
  return rodada;
}

Future<Perfil> buscarMeuPerfil() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client
      .get(Uri.parse('https://api.cartola.globo.com/auth/time'),headers : {
        "X-GLB-Token" : "1059ef5ba50cf0dc59f8221f6496e5a2a4e722d594669724a414f75785a427566373435556b317159444547695361545751626a5872473757732d786d646b4968475f742d37386c54774545684c6e4c7a43756279524c522d506d656d526446477676516575773d3d3a303a72616661656c2e6368696172656c69" }
  );
  final Map<String, dynamic> decodedJson = json.decode(response.body);

  Map dadosTime = decodedJson['time'];
  List<Atleta> listaTitulares = [];
  List<Atleta> listaReservas = [];
  for (Map<String, dynamic> t in decodedJson["atletas"]) {
  final Scout scout = Scout(
  t['scout']['CA'],
  t['scout']['DS'],
  t['scout']['FC'],
  t['scout']['FF'],
  t['scout']['FS'],
  t['scout']['PI'],
  t['scout']['SG'],
  t['scout']['A'],
  t['scout']['FD'],
  t['scout']['FT'],
  t['scout']['G'],
  t['scout']['I'],
  t['scout']['PS'],
  t['scout']['DE'],
  t['scout']['GS'],
  t['scout']['PC'],
  t['scout']['VC'],
  t['scout']['GC'],
  t['scout']['PP'],
  t['scout']['DP'],
  );
  Atleta titular = Atleta(
      scout,
      t['atleta_id'],
      t['rodada_id'],
      t['clube_id'],
      t['posicao_id'],
      t['status_id'],
      double.parse(t['pontos_num'].toString()),
      double.parse(t['preco_num'].toString()),
      double.parse(t['variacao_num'].toString()),
      double.parse(t['media_num'].toString()),
      t['jogos_num'],
      double.parse(t['minimo_para_valorizar'].toString()),
      t['slug'],
      t['apelido'],
      t['apelido_abreviado'],
      t['nome'],
      t['foto'] == null ? "" : t['foto'],
      Icon(Icons.person_off)
  );
  listaTitulares.add(titular);
}

  for (Map<String, dynamic> r in decodedJson["reservas"]) {
    final Scout scout = Scout(
      r['scout']['CA'],
      r['scout']['DS'],
      r['scout']['FC'],
      r['scout']['FF'],
      r['scout']['FS'],
      r['scout']['PI'],
      r['scout']['SG'],
      r['scout']['A'],
      r['scout']['FD'],
      r['scout']['FT'],
      r['scout']['G'],
      r['scout']['I'],
      r['scout']['PS'],
      r['scout']['DE'],
      r['scout']['GS'],
      r['scout']['PC'],
      r['scout']['VC'],
      r['scout']['GC'],
      r['scout']['PP'],
      r['scout']['DP'],
    );
    Atleta reserva = Atleta(
        scout,
        r['atleta_id'],
        r['rodada_id'],
        r['clube_id'],
        r['posicao_id'],
        r['status_id'],
        double.parse(r['pontos_num'].toString()),
        double.parse(r['preco_num'].toString()),
        double.parse(r['variacao_num'].toString()),
        double.parse(r['media_num'].toString()),
        r['jogos_num'],
        double.parse(r['minimo_para_valorizar'].toString()),
        r['slug'],
        r['apelido'],
        r['apelido_abreviado'],
        r['nome'],
        r['foto'] == null ? "" : r['foto'],
        Icon(Icons.person_off)
    );
    listaTitulares.add(reserva);
  }

  final MeuTime time = MeuTime(
    dadosTime['nome'],
    dadosTime['slug'],
    dadosTime['url_escudo_png'],
    dadosTime['url_camisa_png'],
    dadosTime['foto_perfil'],
    dadosTime['time_id'],
    dadosTime['clube_id'],
  );



  final Perfil meuTime = Perfil(
    listaTitulares,
    listaReservas,
    time,
    decodedJson['pontos_campeonato'],
    decodedJson['pontos'],
    decodedJson['esquema_id'],
    decodedJson['rodada_atual'],

    decodedJson['patrimonio'],
    decodedJson['valor_time'],
    decodedJson['total_ligas'],
    decodedJson['variacao_patrimonio'],
    decodedJson['variacao_pontos']
  );

return meuTime;
}


String numeroRodada(){
  String str = '';

  selecionaRodada().then((result){
    str = result.numRodada.toString();
  });
  return str;
}

Future<double> pontuacaoNaRodada(int atletaId) async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response;

  response = await client.get(
      Uri.parse('https://api.cartola.globo.com/mercado/status'));
  var data =  json.decode(response.body);
  var status = data['status_mercado'];
  if (status == 2)
  {
    final Response responsePontuacao = await client.get(
        Uri.parse('https://api.cartola.globo.com/atletas/pontuados'));
    final Map<String, dynamic> decodedJson = json.decode(responsePontuacao.body);
    Map info = decodedJson['atletas'];
    var pontos = info['${atletaId}']['pontuacao'];
    print(pontos);
    if (pontos != null){

      return pontos;

    }
    else{
      return 0.0;
    }

  }
  else
  {
  return 0.0;
  }
  return 0.0;

}

Future<List<MaisEscalados>> listarMaisEscalados() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(
      Uri.parse('https://api.cartola.globo.com/mercado/destaques'));
   var data =  json.decode(response.body);
  final List<MaisEscalados> maisEscalados = [];
  //print (data);
  for (var v in data){
    final MaisEscalados maisEscalado = MaisEscalados.name(
      v['posicao'],
      v['posicao_abreviacao'],
      v['clube'],
      v['escudo_clube'],
      v['clube_id'],
      v['escalacoes'],
      AtletaResumido(
        v['Atleta']['nome'],
        v['Atleta']['apelido'],
        v['Atleta']['apelido_abreviado'],
        v['Atleta']['foto'],
        v['Atleta']['atleta_id'],
        v['Atleta']['preco_editorial'],

      ),
      v['clube_nome'],
      );
maisEscalados.add(maisEscalado);


  }
  return maisEscalados;
}

Future<List<Atleta>> listarAtletas(int clube_id) async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(
      Uri.parse('https://api.cartola.globo.com/atletas/mercado/${clube_id}'));
  final Map<String, dynamic> decodedJson = json.decode(response.body);
  final List<Atleta> listaAtletas = [];

  for (Map<String, dynamic> data in decodedJson["atletas"]) {
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

