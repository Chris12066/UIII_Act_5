import '../drawer_menu.dart';
import 'package:flutter/material.dart';

class Referencias extends StatelessWidget {
  static const routeName = "/referencias";
  const Referencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Referencias', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff000000),
        elevation: 8,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerMenu(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://github.com/geekyshow1/flutter_fbfirestore_crud/tree/master",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://youtu.be/bnZUyHNaxfU",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://github.com/codigoalphacol/Flutter-Login-Firebase",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://youtu.be/sHqrawmQq2w",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://github.com/TarekAlabd/Authentication-With-Amazing-UI-Flutter",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "https://github.com/PaolaIbarraOrdaz/loginCbtis128",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ])),
          )
        ],
      ),
    );
  }
}
