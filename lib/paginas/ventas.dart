import 'package:alcantara/main.dart';
import 'package:alcantara/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:alcantara/drawer_menu.dart';

class Ventas extends StatelessWidget {
  TextEditingController idempleadooController = TextEditingController(text: "");
  TextEditingController idventaController = TextEditingController(text: "");
  TextEditingController idclientee = TextEditingController(text: "");
  TextEditingController idpiezaaController = TextEditingController(text: "");
  TextEditingController idcarrooController = TextEditingController(text: "");
  TextEditingController fechaaController = TextEditingController(text: "");
  TextEditingController cantidaddController = TextEditingController(text: "");
  TextEditingController preciototalController = TextEditingController(text: "");
  static const String routeName = '/venta';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Ventas",
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
                    Icons.shopping_bag,
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
              future: getVenta(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteVenta(snapshot.data?[index]['uid']);
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
                            title: Text("Venta"),
                            subtitle: Text("ID Cliente: " +
                                snapshot.data?[index]['idclientee'] +
                                "\nID Empleado: " +
                                snapshot.data?[index]['idempleadoo'] +
                                "\nID Pieza: " +
                                snapshot.data?[index]['idpiezaa'] +
                                "\nID Carro: " +
                                snapshot.data?[index]['idcarroo'] +
                                "\nFecha: " +
                                snapshot.data?[index]['fechaa'] +
                                "\nCantidad: " +
                                snapshot.data?[index]['cantidadd']),
                            trailing: Text(
                              "Precio total: \n" +
                                  "\$" +
                                  snapshot.data?[index]['preciototal'],
                              textAlign: TextAlign.center,
                            ),
                            leading: Text(snapshot.data?[index]['idventa']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiApp.editarventa,
                                arguments: {
                                  'idclientee': snapshot.data?[index]
                                      ["idclientee"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idventa': snapshot.data?[index]["idventa"],
                                  'idempleadoo': snapshot.data?[index]
                                      ["idempleadoo"],
                                  'idpiezaa': snapshot.data?[index]["idpiezaa"],
                                  'idcarroo': snapshot.data?[index]["idcarroo"],
                                  'fechaa': snapshot.data?[index]["fechaa"],
                                  'cantidadd': snapshot.data?[index]
                                      ["cantidadd"],
                                  'preciototal': snapshot.data?[index]
                                      ["preciototal"],
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
                        controller: idventaController,
                        decoration: InputDecoration(
                          hintText: "ID Venta",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: idempleadooController,
                        decoration: InputDecoration(
                          hintText: "ID Cliente",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: idclientee,
                        decoration: InputDecoration(
                          hintText: "ID Empleado",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: idpiezaaController,
                        decoration: InputDecoration(
                          hintText: "ID Pieza",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: idcarrooController,
                        decoration: InputDecoration(
                          hintText: "ID Carro",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: fechaaController,
                        decoration: InputDecoration(
                          hintText: "Fecha",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: cantidaddController,
                        decoration: InputDecoration(
                          hintText: "Cantidad",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: preciototalController,
                        decoration: InputDecoration(
                          hintText: "Precio total",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () async {
                          await addVenta(
                                  idventaController.text,
                                  idclientee.text,
                                  idempleadooController.text,
                                  idpiezaaController.text,
                                  idcarrooController.text,
                                  fechaaController.text,
                                  cantidaddController.text,
                                  preciototalController.text)
                              .then((_) {
                            Navigator.pushReplacementNamed(
                                context, MiApp.ventas);
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
