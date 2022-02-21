import 'package:appo_lab/src/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appo_lab/src/providers/main_provider.dart';

import 'dart:developer' as developer;

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map<String, dynamic> values = JwtDecoder.decode(mainProvider.token);
    developer.log(values.toString());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: const Color(0XFFFFFFFF),
          elevation: 0,
          title: const Text(
            "AppoLab - Ajustes", 
            style: TextStyle(color: Color(0xFF787878)),),
          //automaticallyImplyLeading: false,
        ),
        body: ListView(children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(mainProvider.nombre.toString()),
              subtitle: const Text("Nombre"),
              trailing: IconButton(
                  tooltip: "Cerrar sesión",
                  onPressed: () {
                    mainProvider.token = "";
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout)),
            ),
          ),
         /* Card(
            child: ListTile(
                leading: const Icon(Icons.work_sharp),
                title: Text(values["role"].toString().toUpperCase()),
                subtitle: const Text("Rol")),
          ),
          Card(
            child: ListTile(
                leading: const Icon(Icons.people),
                title: values.containsKey("group")
                    ? Text("GRUPO " + values["group"])
                    : const Text("SIN GRUPO"),
                subtitle: const Text("Equipo de trabajo")),
          ),*/
          const SettingMode()
        ]),
      ),
    );
  }
}

class SettingMode extends StatelessWidget {
  const SettingMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.light_mode),
        title: const Text("Modo claro"),
        subtitle: const Text("Habilitar / deshabilitar el modo claro"),
        trailing: Switch(
            value: mainProvider.mode,
            onChanged: (bool value) async {
              mainProvider.mode = value;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool("mode", value);
            }),
      ),
    );
  }
}
