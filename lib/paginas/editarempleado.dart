import 'package:flutter/material.dart';
import '../main.dart';
import 'package:alcantara/services/firebase_service.dart';

class Editarempleado extends StatefulWidget {
  static const String routeName = '/editarempleado';
  const Editarempleado({super.key});
  @override
  State<Editarempleado> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarempleado> {
  TextEditingController nombreeController = TextEditingController(text: "");
  TextEditingController idempleadoController = TextEditingController(text: "");
  TextEditingController apellidosController = TextEditingController(text: "");
  TextEditingController salarioController = TextEditingController(text: "");
  TextEditingController generoeController = TextEditingController(text: "");
  TextEditingController puestoController = TextEditingController(text: "");
  TextEditingController contactoeController = TextEditingController(text: "");
  TextEditingController domicilioController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nombreeController.text = arguments['nombree'];
    idempleadoController.text = arguments['idempleado'];
    apellidosController.text = arguments['apellidos'];
    salarioController.text = arguments['salario'];
    generoeController.text = arguments['generoe'];
    puestoController.text = arguments['puesto'];
    contactoeController.text = arguments['contactoe'];
    domicilioController.text = arguments['domicilioe'];

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff000000),
        ),
        body: CustomScrollView(
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
                      await editEmpleados(
                              arguments['uid'],
                              idempleadoController.text,
                              nombreeController.text,
                              apellidosController.text,
                              salarioController.text,
                              generoeController.text,
                              puestoController.text,
                              contactoeController.text,
                              domicilioController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(context, MiApp.empleado);
                      });
                    },
                    child: Text("Actualizar"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 30),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Color(0xff000000),
                        foregroundColor: Colors.white),
                  ),
                ])))
          ],
        ));
  }
}
