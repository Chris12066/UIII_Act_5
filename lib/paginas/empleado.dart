import 'package:alcantara/main.dart';
import 'package:alcantara/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:alcantara/drawer_menu.dart';

class Empleado extends StatelessWidget {
  TextEditingController nombreeController = TextEditingController(text: "");
  TextEditingController idempleadoController = TextEditingController(text: "");
  TextEditingController apellidosController = TextEditingController(text: "");
  TextEditingController salarioController = TextEditingController(text: "");
  TextEditingController generoeController = TextEditingController(text: "");
  TextEditingController puestoController = TextEditingController(text: "");
  TextEditingController contactoeController = TextEditingController(text: "");
  TextEditingController domicilioController = TextEditingController(text: "");
  static const String routeName = '/empleado';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Empleados",
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
                    Icons.engineering,
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
              future: getEmpleados(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await deleteEmpleados(snapshot.data?[index]['uid']);
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
                            title: Text(snapshot.data?[index]['nombree'] +
                                " " +
                                snapshot.data?[index]['apellidos']),
                            subtitle: Text("Salario: " +
                                snapshot.data?[index]['salario'] +
                                "\nGenero: " +
                                snapshot.data?[index]['generoe'] +
                                "\nPuesto: " +
                                snapshot.data?[index]['puesto'] +
                                "\nContacto: " +
                                snapshot.data?[index]['contactoe'] +
                                "\nDomicilio: " +
                                snapshot.data?[index]['domicilioe']),
                            leading: Text(snapshot.data?[index]['idempleado']),
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                MiApp.editarempleado,
                                arguments: {
                                  'nombree': snapshot.data?[index]["nombree"],
                                  'uid': snapshot.data?[index]["uid"],
                                  'idempleado': snapshot.data?[index]
                                      ["idempleado"],
                                  'apellidos': snapshot.data?[index]
                                      ["apellidos"],
                                  'salario': snapshot.data?[index]["salario"],
                                  'generoe': snapshot.data?[index]["generoe"],
                                  'puesto': snapshot.data?[index]["puesto"],
                                  'contactoe': snapshot.data?[index]
                                      ["contactoe"],
                                  'domicilioe': snapshot.data?[index]
                                      ["domicilioe"],
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
                        controller: idempleadoController,
                        decoration: InputDecoration(
                          hintText: "ID Empleado",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: nombreeController,
                        decoration: InputDecoration(
                          hintText: "Nombre",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: apellidosController,
                        decoration: InputDecoration(
                          hintText: "Apellidos",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: salarioController,
                        decoration: InputDecoration(
                          hintText: "Salario",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: generoeController,
                        decoration: InputDecoration(
                          hintText: "Genero",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: puestoController,
                        decoration: InputDecoration(
                          hintText: "Puesto",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: contactoeController,
                        decoration: InputDecoration(
                          hintText: "Contacto",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      TextField(
                        controller: domicilioController,
                        decoration: InputDecoration(
                          hintText: "Domicilio",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                        onPressed: () async {
                          await addEmpleados(
                                  idempleadoController.text,
                                  nombreeController.text,
                                  apellidosController.text,
                                  salarioController.text,
                                  generoeController.text,
                                  puestoController.text,
                                  contactoeController.text,
                                  domicilioController.text)
                              .then((_) {
                            Navigator.pushReplacementNamed(
                                context, MiApp.empleado);
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
