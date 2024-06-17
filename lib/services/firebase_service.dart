import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getCarro() async {
  List carro = [];
  CollectionReference collectionReferenceCarros = db.collection('carro');

  QuerySnapshot querySnapshot = await collectionReferenceCarros.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map car = {
      "idcarro": data["idcarro"],
      "marca": data["marca"],
      "modelo": data["modelo"],
      "anio": data["anio"],
      "color": data["color"],
      "tipo": data["tipo"],
      "cilindros": data["cilindros"],
      "tipomotor": data["tipomotor"],
      "uid": doc.id,
    };

    carro.add(car);
  }

  return carro;
}

Future<void> addCarro(String id, String marca, String modelo, String anio,
    String color, String tipo, String cilindros, String tipomotor) async {
  await db.collection('carro').add({
    "marca": marca,
    "idcarro": id,
    "modelo": modelo,
    "anio": anio,
    "color": color,
    "tipo": tipo,
    "cilindros": cilindros,
    "tipomotor": tipomotor
  });
}

Future<void> editCarro(
    String uid,
    String id,
    String marca,
    String modelo,
    String anio,
    String color,
    String tipo,
    String cilindros,
    String tipomotor) async {
  await db.collection('carro').doc(uid).set({
    "marca": marca,
    "idcarro": id,
    "modelo": modelo,
    "anio": anio,
    "color": color,
    "tipo": tipo,
    "cilindros": cilindros,
    "tipomotor": tipomotor
  });
}

Future<void> deleteCarro(String uid) async {
  await db.collection("carro").doc(uid).delete();
}

Future<List> getPieza() async {
  List empleados = [];
  CollectionReference collectionReferenceCarros = db.collection('pieza');

  QuerySnapshot querySnapshot = await collectionReferenceCarros.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map car = {
      "idpieza": data["idpieza"],
      "idcarro": data["idcarro"],
      "nombrepieza": data["nombrepieza"],
      "tipo": data["tipo"],
      "sistema": data["sistema"],
      "lugar": data["lugar"],
      "cantidad": data["cantidad"],
      "preciop": data["preciop"],
      "uid": doc.id,
    };

    empleados.add(car);
  }

  return empleados;
}

Future<void> addPieza(
    String id,
    String idcarro,
    String nombrepieza,
    String tipo,
    String sistema,
    String lugar,
    String cantidad,
    String preciop) async {
  await db.collection('pieza').add({
    "idcarro": idcarro,
    "idpieza": id,
    "nombrepieza": nombrepieza,
    "tipo": tipo,
    "sistema": sistema,
    "lugar": lugar,
    "cantidad": cantidad,
    "preciop": preciop
  });
}

Future<void> editPieza(
    String uid,
    String id,
    String idcarro,
    String nombrepieza,
    String tipo,
    String sistema,
    String lugar,
    String cantidad,
    String preciop) async {
  await db.collection('pieza').doc(uid).set({
    "idcarro": idcarro,
    "idpieza": id,
    "nombrepieza": nombrepieza,
    "tipo": tipo,
    "sistema": sistema,
    "lugar": lugar,
    "cantidad": cantidad,
    "preciop": preciop
  });
}

Future<void> deletePieza(String uid) async {
  await db.collection("pieza").doc(uid).delete();
}

Future<List> getEmpleados() async {
  List empleados = [];
  CollectionReference collectionReferenceCarros = db.collection('empleados');

  QuerySnapshot querySnapshot = await collectionReferenceCarros.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map car = {
      "idempleado": data["idempleado"],
      "nombree": data["nombree"],
      "apellidos": data["apellidos"],
      "salario": data["salario"],
      "generoe": data["generoe"],
      "puesto": data["puesto"],
      "contactoe": data["contactoe"],
      "domicilioe": data["domicilioe"],
      "uid": doc.id,
    };

    empleados.add(car);
  }

  return empleados;
}

Future<void> addEmpleados(
    String id,
    String nombree,
    String apellidos,
    String salario,
    String generoe,
    String puesto,
    String contactoe,
    String domicilioe) async {
  await db.collection('empleados').add({
    "nombree": nombree,
    "idempleado": id,
    "apellidos": apellidos,
    "salario": salario,
    "generoe": generoe,
    "puesto": puesto,
    "contactoe": contactoe,
    "domicilioe": domicilioe
  });
}

Future<void> editEmpleados(
    String uid,
    String id,
    String nombree,
    String apellidos,
    String salario,
    String generoe,
    String puesto,
    String contactoe,
    String domicilioe) async {
  await db.collection('empleados').doc(uid).set({
    "nombree": nombree,
    "idempleado": id,
    "apellidos": apellidos,
    "salario": salario,
    "generoe": generoe,
    "puesto": puesto,
    "contactoe": contactoe,
    "domicilioe": domicilioe
  });
}

Future<void> deleteEmpleados(String uid) async {
  await db.collection("empleados").doc(uid).delete();
}

Future<List> getCliente() async {
  List clientes = [];
  CollectionReference collectionReferenceCarros = db.collection('cliente');

  QuerySnapshot querySnapshot = await collectionReferenceCarros.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map car = {
      "idcliente": data["idcliente"],
      "nombrec": data["nombrec"],
      "apellidopaterno": data["apellidopaterno"],
      "apellidomaterno": data["apellidomaterno"],
      "contactoc": data["contactoc"],
      "fechac": data["fechac"],
      "generoc": data["generoc"],
      "domicilioc": data["domicilioc"],
      "uid": doc.id,
    };

    clientes.add(car);
  }

  return clientes;
}

Future<void> addCliente(
    String id,
    String nombrec,
    String apellidopaterno,
    String apellidomaterno,
    String contactoc,
    String fechac,
    String generoc,
    String domicilioc) async {
  await db.collection('cliente').add({
    "nombrec": nombrec,
    "idcliente": id,
    "apellidopaterno": apellidopaterno,
    "apellidomaterno": apellidomaterno,
    "contactoc": contactoc,
    "fechac": fechac,
    "generoc": generoc,
    "domicilioc": domicilioc
  });
}

Future<void> editCliente(
    String uid,
    String id,
    String nombrec,
    String apellidopaterno,
    String apellidomaterno,
    String contactoc,
    String fechac,
    String generoc,
    String domicilioc) async {
  await db.collection('cliente').doc(uid).set({
    "nombrec": nombrec,
    "idcliente": id,
    "apellidopaterno": apellidopaterno,
    "apellidomaterno": apellidomaterno,
    "contactoc": contactoc,
    "fechac": fechac,
    "generoc": generoc,
    "domicilioc": domicilioc
  });
}

Future<void> deleteCliente(String uid) async {
  await db.collection("cliente").doc(uid).delete();
}

Future<List> getVenta() async {
  List venta = [];
  CollectionReference collectionReferenceCarros = db.collection('venta');

  QuerySnapshot querySnapshot = await collectionReferenceCarros.get();
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Map car = {
      "idventa": data["idventa"],
      "idempleadoo": data["idempleadoo"],
      "idclientee": data["idclientee"],
      "idpiezaa": data["idpiezaa"],
      "idcarroo": data["idcarroo"],
      "fechaa": data["fechaa"],
      "cantidadd": data["cantidadd"],
      "preciototal": data["preciototal"],
      "uid": doc.id,
    };

    venta.add(car);
  }

  return venta;
}

Future<void> addVenta(
    String id,
    String idempleadoo,
    String idclientee,
    String idpiezaa,
    String idcarroo,
    String fechaa,
    String cantidadd,
    String preciototal) async {
  await db.collection('venta').add({
    "idempleadoo": idempleadoo,
    "idventa": id,
    "idclientee": idclientee,
    "idpiezaa": idpiezaa,
    "idcarroo": idcarroo,
    "fechaa": fechaa,
    "cantidadd": cantidadd,
    "preciototal": preciototal
  });
}

Future<void> editVenta(
    String uid,
    String id,
    String idempleadoo,
    String idclientee,
    String idpiezaa,
    String idcarroo,
    String fechaa,
    String cantidadd,
    String preciototal) async {
  await db.collection('venta').doc(uid).set({
    "idempleadoo": idempleadoo,
    "idventa": id,
    "idclientee": idclientee,
    "idpiezaa": idpiezaa,
    "idcarroo": idcarroo,
    "fechaa": fechaa,
    "cantidadd": cantidadd,
    "preciototal": preciototal
  });
}

Future<void> deleteVenta(String uid) async {
  await db.collection("venta").doc(uid).delete();
}
