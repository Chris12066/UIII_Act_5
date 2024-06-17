import 'package:flutter/material.dart';
import '../main.dart';
import 'package:alcantara/services/firebase_service.dart';

class Editarcliente extends StatefulWidget {
  static const String routeName = '/editarcliente';
  const Editarcliente({super.key});
  @override
  State<Editarcliente> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarcliente> {
  TextEditingController nombrec = TextEditingController(text: "");
  TextEditingController idclienteController = TextEditingController(text: "");
  TextEditingController apellidopaternoController =
      TextEditingController(text: "");
  TextEditingController apellidomaternoController =
      TextEditingController(text: "");
  TextEditingController contactocController = TextEditingController(text: "");
  TextEditingController fechacController = TextEditingController(text: "");
  TextEditingController generocController = TextEditingController(text: "");
  TextEditingController domiciliocController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nombrec.text = arguments['nombrec'];
    idclienteController.text = arguments['idcliente'];
    apellidopaternoController.text = arguments['apellidopaterno'];
    apellidomaternoController.text = arguments['apellidomaterno'];
    contactocController.text = arguments['contactoc'];
    fechacController.text = arguments['fechac'];
    generocController.text = arguments['generoc'];
    domiciliocController.text = arguments['domicilioc'];

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
                    controller: idclienteController,
                    decoration: InputDecoration(
                      hintText: "ID Cliente",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: nombrec,
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
                    controller: fechacController,
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
                      await editCliente(
                              arguments['uid'],
                              idclienteController.text,
                              nombrec.text,
                              apellidopaternoController.text,
                              apellidomaternoController.text,
                              contactocController.text,
                              fechacController.text,
                              generocController.text,
                              domiciliocController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(context, MiApp.cliente);
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
