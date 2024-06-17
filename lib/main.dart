import 'dart:async';
import 'package:alcantara/paginas/editarventa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alcantara/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'drawer_menu.dart';

import 'paginas/carro.dart';
import 'paginas/editarcarro.dart';
import 'paginas/editarpieza.dart';
import 'paginas/editarempleado.dart';
import 'paginas/editarcliente.dart';
import 'paginas/pieza.dart';
import 'paginas/empleado.dart';
import 'paginas/clientes.dart';
import 'paginas/ventas.dart';
import 'paginas/referencias.dart';
import 'paginas/ubicacion.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  static const String routeName = "/main";
  static const String inicio = PaginaInicio.routeName;
  static const String ubicacion = MapSample.routeName;
  static const String carro = Carro.routeName;
  static const String editarcarro = Editarcarro.routeName;
  static const String editarpieza = Editarpieza.routeName;
  static const String editarempleado = Editarempleado.routeName;
  static const String editarcliente = Editarcliente.routeName;
  static const String editarventa = Editarventas.routeName;
  static const String pieza = Pieza.routeName;
  static const String empleado = Empleado.routeName;
  static const String cliente = Cliente.routeName;
  static const String ventas = Ventas.routeName;
  static const String referencias = Referencias.routeName;
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piscinas Poolman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaSesion(),
      routes: {
        inicio: (context) => PaginaInicio(),
        ubicacion: (context) => MapSample(),
        carro: (context) => Carro(),
        editarcarro: (context) => Editarcarro(),
        editarpieza: (context) => Editarpieza(),
        editarempleado: (context) => Editarempleado(),
        editarcliente: (context) => Editarcliente(),
        editarventa: (context) => Editarventas(),
        pieza: (context) => Pieza(),
        empleado: (context) => Empleado(),
        cliente: (context) => Cliente(),
        ventas: (context) => Ventas(),
        referencias: (context) => Referencias(),
      },
    );
  }
}

class PaginaSesion extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: prefer_final_fields
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('usuario');

  PaginaSesion({super.key});

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String contrasena = _passwordController.text;

    QuerySnapshot querySnapshot = await _usersCollection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: contrasena)
        .get();

    if (querySnapshot.size > 0) {
      // Inicio de sesión exitoso, redirigir a la página principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaInicio()),
      );
    } else {
      // Mostrar un diálogo de error en caso de inicio de sesión fallido
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content:
                const Text('Credenciales incorrectas. Inténtalo de nuevo.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _registro(BuildContext context) async {
    String email = _emailController.text;
    String contrasena = _passwordController.text;

    QuerySnapshot querySnapshot =
        await _usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.size > 0) {
      // Mostrar un diálogo de error en caso de que el usuario ya esté registrado
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de registro'),
            content: const Text('El usuario ya está registrado.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Registrar al usuario en Firestore
      await _usersCollection.add({
        'email': email,
        'password': contrasena,
      });

      // Mostrar un diálogo de registro exitoso
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registro exitoso'),
            content: const Text('El usuario ha sido registrado correctamente.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Refaccionaria', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff000000),
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              "Inicio de sesión o registro",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2.5,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(340, 40),
                backgroundColor: const Color(0xff000000),
              ),
              onPressed: () => _login(context),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Registrarse',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(340, 40),
                backgroundColor: const Color(0xff000000),
              ),
              onPressed: () => _registro(context),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaInicio extends StatelessWidget {
  static const String routeName = "/main";

  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Refaccionaria',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff000000),
          elevation: 8,
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.info),
              ),
            ],
          ),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(
                        "https://raw.githubusercontent.com/Chris12066/Img_iOS/main/FlutterFlowA12/articulos.jpg"),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Bienvenido a la mejor refaccionaria en la cual encontraras todo lo que necesites para tu auto sin importar el modelo, año, marca que sea.",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Image(image: AssetImage("assets/DSCF3493.JPG"), width: 150),
                  Text("Christian Alexis Alcantara Gonzalez"),
                  Divider(),
                  Text("Conclusion", style: TextStyle(fontSize: 30)),
                  Text(
                      "En conclusión, este proyecto ha representado un gran desafío al implementar nuestra cretividad, basándome en trabajos anteriores realizados a lo largo del semestre. Durante la implementación de la aplicación, me encontré con diversas dificultades relacionadas con las bases de datos y la integración de Google Maps. Esta experiencia me deja con un valioso aprendizaje que seguramente será útil en futuros proyectos, fortaleciendo mis habilidades y mi capacidad para enfrentar desafíos tecnológicos.")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
