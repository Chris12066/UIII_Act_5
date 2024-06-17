import 'package:flutter/material.dart';
import '../main.dart';
import 'package:alcantara/services/firebase_service.dart';

class Editarventas extends StatefulWidget {
  static const String routeName = '/editarventa';
  const Editarventas({super.key});
  @override
  State<Editarventas> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<Editarventas> {
  TextEditingController idempleadooController = TextEditingController(text: "");
  TextEditingController idventaController = TextEditingController(text: "");
  TextEditingController idclienteeController = TextEditingController(text: "");
  TextEditingController idpiezaaController = TextEditingController(text: "");
  TextEditingController idcarrooController = TextEditingController(text: "");
  TextEditingController fechaaController = TextEditingController(text: "");
  TextEditingController cantidaddController = TextEditingController(text: "");
  TextEditingController preciototalController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    idclienteeController.text = arguments['idclientee'];
    idventaController.text = arguments['idventa'];
    idempleadooController.text = arguments['idempleadoo'];
    idpiezaaController.text = arguments['idpiezaa'];
    idcarrooController.text = arguments['idcarroo'];
    fechaaController.text = arguments['fechaa'];
    cantidaddController.text = arguments['cantidadd'];
    preciototalController.text = arguments['preciototal'];

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
                    controller: idventaController,
                    decoration: InputDecoration(
                      hintText: "ID Venta",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: idclienteeController,
                    decoration: InputDecoration(
                      hintText: "Id Cliente",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: idempleadooController,
                    decoration: InputDecoration(
                      hintText: "ID Empleado",
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: idpiezaaController,
                    decoration: InputDecoration(
                      hintText: "ID Piezas",
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
                      await editVenta(
                              arguments['uid'],
                              idventaController.text,
                              idclienteeController.text,
                              idempleadooController.text,
                              idpiezaaController.text,
                              idcarrooController.text,
                              fechaaController.text,
                              cantidaddController.text,
                              preciototalController.text)
                          .then((_) {
                        Navigator.pushReplacementNamed(context, MiApp.ventas);
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
