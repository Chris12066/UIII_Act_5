import 'package:flutter/material.dart';
import '../main.dart';
import 'package:alcantara/services/firebase_service.dart';

class Editarpieza extends StatefulWidget {
  static const String routeName = '/editarpieza';
  const Editarpieza({super.key});
  @override
  State<Editarpieza> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarpieza> {
  TextEditingController idcarroController = TextEditingController(text: "");
  TextEditingController idpiezaController = TextEditingController(text: "");
  TextEditingController nombrepiezaController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController sistemaController = TextEditingController(text: "");
  TextEditingController lugarController = TextEditingController(text: "");
  TextEditingController cantidadController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    idcarroController.text = arguments['idcarro'];
    idpiezaController.text = arguments['idpieza'];
    nombrepiezaController.text = arguments['nombrepieza'];
    tipoController.text = arguments['tipo'];
    sistemaController.text = arguments['sistema'];
    lugarController.text = arguments['lugar'];
    cantidadController.text = arguments['cantidad'];
    precioController.text = arguments['preciop'];

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
                      await editPieza(
                              arguments['uid'],
                              idpiezaController.text,
                              idcarroController.text,
                              nombrepiezaController.text,
                              precioController.text,
                              sistemaController.text,
                              lugarController.text,
                              cantidadController.text,
                              precioController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(context, MiApp.pieza);
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
