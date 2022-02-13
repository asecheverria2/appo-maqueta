import 'package:appo_lab/src/models/user_model.dart';
import 'package:appo_lab/src/models/usuario_data_model.dart';
import 'package:flutter/material.dart';
import 'package:appo_lab/src/services/user_service.dart';
import 'package:appo_lab/src/widgets/login_widget.dart';

import 'package:appo_lab/src/utils/user_preferences.dart';

class UsuarioRegister extends StatefulWidget {
  UsuarioRegister({Key? key}) : super(key: key);

  @override
  _UsuarioRegisterState createState() => _UsuarioRegisterState();
}

class _UsuarioRegisterState extends State<UsuarioRegister> {
  final UserService _userService = UserService();
  late Usuario _user;

  final _formKey = GlobalKey<FormState>();

  bool? darkModePrefs;
  @override
  void initState() {
    super.initState();
    /*_loadDarkModePrefs();*/
    _user = Usuario.create("", "", "");
  }

  @override
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: _heigth * 0.3,
            width: _width,
            color: darkModePrefs == false ? Colors.green : Colors.black,
            /*child: darkModePrefs == false
                ? Image.asset('assets/images/logo.png')
                : Image.asset('assets/images/logodark.png'),*/
          ),
          Container(
              color: darkModePrefs == false ? Colors.green : Colors.black,
              child: Container(
                  decoration: BoxDecoration(
                      color: darkModePrefs == false
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Title(
                            color: Colors.black,
                            child: Text(
                              'Registrar Usuario',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: darkModePrefs == false
                                      ? Colors.black
                                      : Colors.grey[400]),
                            ),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: _user.username,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.orangeAccent),
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.badge),
                                      labelText: 'Nombre'),
                                  onSaved: (value) {
                                    _user.username = value.toString();
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                TextFormField(
                                  initialValue: _user.email,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.orangeAccent),
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.alternate_email),
                                      labelText: 'Correo Electronico'),
                                  validator: (value) {
                                    if (value!.isEmpty || !value.contains('@')) {
                                      return 'Correo invalido';
                                    }
                                  },
                                  onSaved: (value) {
                                    _user.email = value.toString();
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                TextFormField(
                                  obscureText: true,
                                  initialValue: _user.password,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.orangeAccent),
                                  decoration: const InputDecoration(
                                    
                                      icon: Icon(Icons.vpn_key),
                                      labelText: 'Contraseña'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 5) {
                                      return 'Contraseña muy corta';
                                    }
                                  },
                                  onSaved: (value) {
                                    _user.password = value.toString();
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                Divider(
                                  color: darkModePrefs == false
                                      ? Colors.white
                                      : Colors.grey[850],
                                ),
                                MaterialButton(
                                  minWidth: 200.0,
                                  height: 50.0,
                                  color: darkModePrefs == false
                                      ? Colors.green
                                      : Colors.tealAccent,
                                  child: Text(
                                    'Crear Cuenta',
                                    style: TextStyle(
                                        color: darkModePrefs == false
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 20.0),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Processing Data')));
                                                  _formKey.currentState!.save();
                                    setState(() {
                                      _userService
                                          .sendUser(_user)
                                          .then((value) {
                                        _formKey.currentState!.reset();
                              
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      });
                                    });
                                    }
                                    
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ],
                            )),
                        Divider(
                          color: darkModePrefs == false
                              ? Colors.white
                              : Colors.grey[850],
                        ),
                        Divider(
                          color: darkModePrefs == false
                              ? Colors.white
                              : Colors.grey[850],
                        ),
                        MaterialButton(
                          minWidth: 200.0,
                          height: 50.0,
                          color: darkModePrefs == false
                              ? Colors.green
                              : Colors.tealAccent,
                          child: Text(
                            'Regresar',
                            style: TextStyle(
                                color: darkModePrefs == false
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        Divider(
                          color: darkModePrefs == false
                              ? Colors.white
                              : Colors.grey[850],
                        ),
                        Divider(
                          color: darkModePrefs == false
                              ? Colors.white
                              : Colors.grey[850],
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    ));
  }

  /*_loadDarkModePrefs() async {
    darkModePrefs = await getDarkMode();
    setState(() {});
  }*/
}
