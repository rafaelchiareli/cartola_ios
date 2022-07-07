import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/models/clube.dart';
import 'package:cartola_ios/screens/atletas_time.dart';
import 'package:flutter/material.dart';

import '../widgets/progress.dart';

class Times extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Times'),
      ),
      body: FutureBuilder<List<Clube>>(
          future: listarClubes(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Clube> clubes = snapshot.data!;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Clube clube = clubes[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(clube.utlEscudo), backgroundColor: Colors.transparent,// no matter how big it is, it won't overflow
                        ),
                        title: Text(
                          clube.nome,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          clube.abreviacao,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                          onTap: () => _showAtletas(context, clube.id)
                      ),
                    );
                  },
                  itemCount: clubes.length,
                );
                break;
            }
            return Text('Erro desconhecido');
          }),
    );
  }
  void _showAtletas(BuildContext context, int clubeId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ListaAtletas(clubeId),
    ));
  }
}
