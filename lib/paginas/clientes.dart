import 'package:alcantara/main.dart';
import 'package:alcantara/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:alcantara/drawer_menu.dart';

class Cliente extends StatelessWidget {
  TextEditingController nombreController = TextEditingController(text: "");
  TextEditingController idclienteController = TextEditingController(text: "");
  TextEditingController apellidopaternoController =
      TextEditingController(text: "");
  TextEditingController apellidomaternoController =
      TextEditingController(text: "");
  TextEditingController contactocController = TextEditingController(text: "");
  TextEditingController fechaController = TextEditingController(text: "");
  TextEditingController generocController = TextEditingController(text: "");
  TextEditingController domiciliocController = TextEditingController(text: "");
  static const String routeName = '/clientes';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cliente",
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
                    Icons.person,
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
              future: getCliente(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteCliente(snapshot.data?[index]['uid']);
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
                            title: Text(snapshot.data?[index]['nombrec'] +
                                " " +
                                snapshot.data?[index]['apellidopaterno'] +
                                " " +
                                snapshot.data?[index]['apellidomaterno']),
                            subtitle: Text("Contacto: " +
                                snapshot.data?[index]['contactoc'] +
                                "\nFecha: " +
                                snapshot.data?[index]['fechac'] +
                                "\nGenero: " +
                                snapshot.data?[index]['generoc'] +
                                "\nDomicilio: " +
                                snapshot.data?[index]['domicilioc']),
                            leading: Text(snapshot.data?[index]['idcliente']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiApp.editarcliente,
                                arguments: {
                                  'nombrec': snapshot.data?[index]["nombrec"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idcliente': snapshot.data?[index]
                                      ["idcliente"],
                                  'apellidopaterno': snapshot.data?[index]
                                      ["apellidopaterno"],
                                  'apellidomaterno': snapshot.data?[index]
                                      ["apellidomaterno"],
                                  'contactoc': snapshot.data?[index]
                                      ["contactoc"],
                                  'fechac': snapshot.data?[index]["fechac"],
                                  'generoc': snapshot.data?[index]["generoc"],
                                  'domicilioc': snapshot.data?[index]
                                      ["domicilioc"],
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
                        controller: idclienteController,
                        decoration: InputDecoration(
                          hintText: "ID Cliente",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          hintText: "Nombre",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: apellidopaternoController,
                        decoration: InputDecoration(
                          hintText: "Apellido paterno",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: apellidomaternoController,
                        decoration: InputDecoration(
                          hintText: "Apellido materno",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: contactocController,
                        decoration: InputDecoration(
                          hintText: "Contacto",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: fechaController,
                        decoration: InputDecoration(
                          hintText: "Fecha",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: generocController,
                        decoration: InputDecoration(
                          hintText: "Genero",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: domiciliocController,
                        decoration: InputDecoration(
                          hintText: "Domicilio",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () async {
                          await addCliente(
                                  idclienteController.text,
                                  nombreController.text,
                                  apellidopaternoController.text,
                                  apellidomaternoController.text,
                                  contactocController.text,
                                  fechaController.text,
                                  generocController.text,
                                  domiciliocController.text)
                              .then((_) {
                            Navigator.pushReplacementNamed(
                                context, MiApp.cliente);
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
