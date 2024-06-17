import 'package:flutter/material.dart';
import '../main.dart';
import 'package:alcantara/services/firebase_service.dart';

class Editarcarro extends StatefulWidget {
  static const String routeName = '/editarcarro';
  const Editarcarro({super.key});
  @override
  State<Editarcarro> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarcarro> {
  TextEditingController marcaController = TextEditingController(text: "");
  TextEditingController idcarroController = TextEditingController(text: "");
  TextEditingController modeloController = TextEditingController(text: "");
  TextEditingController anioController = TextEditingController(text: "");
  TextEditingController colorController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController cilindrosController = TextEditingController(text: "");
  TextEditingController tipomotorController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    marcaController.text = arguments['marca'];
    idcarroController.text = arguments['idcarro'];
    modeloController.text = arguments['modelo'];
    anioController.text = arguments['anio'];
    colorController.text = arguments['color'];
    tipoController.text = arguments['tipo'];
    cilindrosController.text = arguments['cilindros'];
    tipomotorController.text = arguments['tipomotor'];

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Editarcarro',
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
                      await editCarro(
                              arguments['uid'],
                              idcarroController.text,
                              marcaController.text,
                              modeloController.text,
                              anioController.text,
                              colorController.text,
                              tipoController.text,
                              cilindrosController.text,
                              tipomotorController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(context, MiApp.carro);
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
