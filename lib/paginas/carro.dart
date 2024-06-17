import 'package:alcantara/main.dart';
import 'package:alcantara/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:alcantara/drawer_menu.dart';

class Carro extends StatelessWidget {
  TextEditingController marcaController = TextEditingController(text: "");
  TextEditingController idcarroController = TextEditingController(text: "");
  TextEditingController modeloController = TextEditingController(text: "");
  TextEditingController anioController = TextEditingController(text: "");
  TextEditingController colorController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController cilindrosController = TextEditingController(text: "");
  TextEditingController tipomotorController = TextEditingController(text: "");
  static const String routeName = '/carro';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Carros",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff000000),
          bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.car_rental,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.add_circle),
                )
              ]),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: getCarro(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteCarro(snapshot.data?[index]['uid']);
                            snapshot.data?.removeAt(index);
                          },
                          confirmDismiss: (direction) async {
                            bool result = false;
                            result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        "¿Estás seguro de eliminar este registro?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, false);
                                        },
                                        child: Text("Cancelar"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, true);
                                        },
                                        child: Text("Si, estoy seguro"),
                                      ),
                                    ],
                                  );
                                });
                            return result;
                          },
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ),
                          direction: DismissDirection.endToStart,
                          key: Key(snapshot.data?[index]['uid']),
                          child: ListTile(
                            title: Text(snapshot.data?[index]['marca'] +
                                " " +
                                snapshot.data?[index]['modelo']),
                            subtitle: Text("Año: " +
                                snapshot.data?[index]['anio'] +
                                "\nColor: " +
                                snapshot.data?[index]['color'] +
                                "\nTipo: " +
                                snapshot.data?[index]['tipo'] +
                                "\nCilindros: " +
                                snapshot.data?[index]['cilindros'] +
                                "\nTipo de motor: " +
                                snapshot.data?[index]['tipomotor']),
                            leading: Text(snapshot.data?[index]['idcarro']),
                            onTap: () => {
                              Navigator.pushNamed(context, MiApp.editarcarro,
                                  arguments: {
                                    'marca': snapshot.data?[index]["marca"],
                                    'uid': snapshot.data?[index]["uid"],
                                    'idcarro': snapshot.data?[index]["idcarro"],
                                    'modelo': snapshot.data?[index]["modelo"],
                                    'anio': snapshot.data?[index]["anio"],
                                    'color': snapshot.data?[index]["color"],
                                    'tipo': snapshot.data?[index]["tipo"],
                                    'cilindros': snapshot.data?[index]
                                        ["cilindros"],
                                    'tipomotor': snapshot.data?[index]
                                        ["tipomotor"],
                                  })
                            },
                          ));
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                    padding: EdgeInsets.all(10),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      TextField(
                        controller: idcarroController,
                        decoration: InputDecoration(
                          hintText: "ID Carro",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: marcaController,
                        decoration: InputDecoration(
                          hintText: "Marca",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: modeloController,
                        decoration: InputDecoration(
                          hintText: "Modelo",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: anioController,
                        decoration: InputDecoration(
                          hintText: "Año",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: colorController,
                        decoration: InputDecoration(
                          hintText: "Color",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: tipoController,
                        decoration: InputDecoration(
                          hintText: "Tipo",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: cilindrosController,
                        decoration: InputDecoration(
                          hintText: "Cilindros",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: tipomotorController,
                        decoration: InputDecoration(
                          hintText: "Tipo de motor",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () async {
                          await addCarro(
                                  idcarroController.text,
                                  marcaController.text,
                                  modeloController.text,
                                  anioController.text,
                                  colorController.text,
                                  tipoController.text,
                                  cilindrosController.text,
                                  tipomotorController.text)
                              .then((_) {
                            Navigator.pushReplacementNamed(
                                context, MiApp.carro);
                          });
                        },
                        child: Text("Guardar"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(200, 30),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Color(0xff000000),
                            foregroundColor: Colors.white),
                      ),
                    ])))
              ],
            )
          ],
        ),
      ),
    );
  }
}
