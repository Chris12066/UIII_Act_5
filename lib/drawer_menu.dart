import 'package:flutter/material.dart';
import 'main.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  void _cerrarSesion(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PaginaSesion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(""),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://raw.githubusercontent.com/Chris12066/Img_iOS/main/s13.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home_outlined),
                Padding(padding: EdgeInsets.all(10)),
                Text("Inicio")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiApp.inicio)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.car_crash),
                Padding(padding: EdgeInsets.all(10)),
                Text("Carros")
              ],
            ),
            onTap: () => {Navigator.pushReplacementNamed(context, MiApp.carro)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.car_repair),
                Padding(padding: EdgeInsets.all(10)),
                Text("Piezas")
              ],
            ),
            onTap: () => {Navigator.pushReplacementNamed(context, MiApp.pieza)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.engineering),
                Padding(padding: EdgeInsets.all(10)),
                Text("Empleados")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiApp.empleado)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.person),
                Padding(padding: EdgeInsets.all(10)),
                Text("Clientes")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiApp.cliente)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.shopping_bag),
                Padding(padding: EdgeInsets.all(10)),
                Text("Ventas")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiApp.ventas)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.location_pin),
                Padding(padding: EdgeInsets.all(10)),
                Text("Ubicacion")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiApp.ubicacion)},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.link),
                Padding(padding: EdgeInsets.all(10)),
                Text("Referencias")
              ],
            ),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, MiApp.referencias)},
          ),
          Padding(padding: EdgeInsets.all(10)),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                Padding(padding: EdgeInsets.all(10)),
                Text("Cerrar sesión")
              ],
            ),
            onTap: () => {_cerrarSesion(context)},
          ),
        ],
      ),
    );
  }
}
