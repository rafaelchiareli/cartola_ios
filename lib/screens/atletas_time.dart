import 'package:cartola_ios/http/webclient.dart';
import 'package:cartola_ios/models/atleta.dart';
import 'package:flutter/material.dart';

import '../models/scout.dart';
import '../widgets/progress.dart';

class ListaAtletas extends StatefulWidget {
  final int clube_id;

  ListaAtletas(this.clube_id);

  @override
  State<ListaAtletas> createState() => _ListaAtletasState();
}

class _ListaAtletasState extends State<ListaAtletas> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Atletas"),
          actions: [
            PopupMenuButton(
                padding: EdgeInsets.fromLTRB(1.0, 2.0, 10.0, 4.0),
                child: Icon(
                  Icons.filter_list_sharp,
                ),
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Dúvida"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Settings"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout"),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {

                  } else if (value == 1) {
                    print("Settings menu is selected.");
                  } else if (value == 2) {
                    print("Logout menu is selected.");
                  }
                }),
            Padding(padding: EdgeInsets.only(right: 15.0))
          ],
        ),
        body: FutureBuilder<List<Atleta>>(
            future: listarAtletas(widget.clube_id),
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
                    itemBuilder: (context, index) {
                      final Atleta atleta = atletas[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(atleta.foto != ""
                                ? atleta.foto.replaceAll('FORMATO', '140x140')
                                : 'https://png.pngtree.com/png-clipart/20190604/original/pngtree-404-error-page-png-image_1362453.jpg'),
                            backgroundColor: Colors.transparent,
                            radius:
                                25, // no matter how big it is, it won't overflow
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  atleta.nome,
                                  style: TextStyle(fontSize: 17),
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
                              child: Row(
                            children: [
                              atleta.icone,
                            ],
                          )),
                          onTap: () => _showMaterialModalBottomSheet(
                              context, atleta.scout),
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
            }));
  }

  // void _runFilter(int status) {
  //   List<Atleta> results = [];
  //
  //
  //     results = listarAtletas(widget.clube_id)
  //         .where((user) =>
  //         user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //
  //
  //   // Refresh the UI
  //   setState(() {
  //     ListaAtletas = results;
  //   });
  // }

  void _showMaterialModalBottomSheet(BuildContext context, Scout? scout) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.lightBlue,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(scout.toString()),
                Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
