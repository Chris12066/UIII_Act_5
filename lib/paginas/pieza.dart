import 'package:alcantara/main.dart';
import 'package:alcantara/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:alcantara/drawer_menu.dart';

class Pieza extends StatelessWidget {
  TextEditingController idcarroController = TextEditingController(text: "");
  TextEditingController idpiezaController = TextEditingController(text: "");
  TextEditingController nombrepiezaController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController sistemaController = TextEditingController(text: "");
  TextEditingController lugarController = TextEditingController(text: "");
  TextEditingController cantidadController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");
  static const String routeName = '/pieza';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Piezas",
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
                    Icons.car_repair,
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
              future: getPieza(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deletePieza(snapshot.data?[index]['uid']);
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
                            title: Text(snapshot.data?[index]['nombrepieza']),
                            subtitle: Text("ID Carro: " +
                                snapshot.data?[index]['idcarro'] +
                                "\nTipo: " +
                                snapshot.data?[index]['tipo'] +
                                "\nSistema: " +
                                snapshot.data?[index]['sistema'] +
                                "\nLugar: " +
                                snapshot.data?[index]['lugar'] +
                                "\nCantidad: " +
                                snapshot.data?[index]['cantidad']),
                            leading: Text(snapshot.data?[index]['idpieza']),
                            trailing:
                                Text("\$" + snapshot.data?[index]['preciop']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiApp.editarpieza,
                                arguments: {
                                  'idcarro': snapshot.data?[index]["idcarro"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idpieza': snapshot.data?[index]["idpieza"],
                                  'nombrepieza': snapshot.data?[index]
                                      ["nombrepieza"],
                                  'preciop': snapshot.data?[index]["preciop"],
                                  'tipo': snapshot.data?[index]["tipo"],
                                  'lugar': snapshot.data?[index]["lugar"],
                                  'sistema': snapshot.data?[index]["sistema"],
                                  'cantidad': snapshot.data?[index]["cantidad"],
                                },
                              ),
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
                        controller: idpiezaController,
                        decoration: InputDecoration(
                          hintText: "ID Pieza",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: idcarroController,
                        decoration: InputDecoration(
                          hintText: "ID Carro",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: nombrepiezaController,
                        decoration: InputDecoration(
                          hintText: "Nombre de la pieza",
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
                        controller: sistemaController,
                        decoration: InputDecoration(
                          hintText: "Sistema",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: lugarController,
                        decoration: InputDecoration(
                          hintText: "Lugar",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: cantidadController,
                        decoration: InputDecoration(
                          hintText: "Cantidad",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: precioController,
                        decoration: InputDecoration(
                          hintText: "Precio",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () async {
                          await addPieza(
                                  idpiezaController.text,
                                  idcarroController.text,
                                  nombrepiezaController.text,
                                  tipoController.text,
                                  sistemaController.text,
                                  lugarController.text,
                                  cantidadController.text,
                                  precioController.text)
                              .then((_) {
                            Navigator.pushReplacementNamed(
                                context, MiApp.pieza);
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
