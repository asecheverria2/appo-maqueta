import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appo_lab/src/pages/menu_page.dart';
import 'package:appo_lab/src/pages/usuario_register.dart';
import 'package:appo_lab/src/bloc/login_bloc.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginBloc bloc;
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    return _sigin();
  }

  _sigin() async {
    final authData = {
      'identifier': _email,
      'password': _password,
    };
    try {
      //final mainProvider = Provider.of<MainProvider>(context);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var uri = Uri.https("appo-backend.herokuapp.com", "/auth/local");
      final resp =
          await http.post(uri, 
            headers: _headers, 
            body: json.encode(authData)
          );
      if (resp.body.isEmpty) return null;
      if(resp.statusCode == 200) {
        //print(resp.body);
        _redirectUser();
      }
      else{
        //print(resp.body);
        _showerrorDialog('Revise si ha ingresado bien su correo o contraseña');
      }
      //mainProvider.token = json.decode(resp.body)['jwt'];
      return json.decode(resp.body);
    } on Exception catch (e) {
      //print("Exception $e");
      return e;
    }
  }

  void _redirectUser() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuPage(),
        ),
        (route) => false,
      );
    });
  }

  bool? darkModePrefs;
  @override
  void initState() {
    bloc = LoginBloc();
    super.initState();
    //_loadDarkModePrefs();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf9f9f9),
        elevation: 0,
      ),
      key: _scaffoldKey,
        body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
                  child: Title(
                    color: Colors.black,
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 25,
                        
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 30.0, bottom: 30.0),
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[400]
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 25.0, bottom: 12.0),
                        child: StreamBuilder(
                          stream: bloc.emailStream,
                          builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                          TextFormField(
                            onChanged: bloc.changeEmail,
                            style: const TextStyle(
                                fontSize: 17.0, color: Colors.orangeAccent),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email,
                                color: Color(0xFF102639),
                              ),
                              hintText: 'usuario@gmail.com',
                              labelText: 'Correo electrónico'
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Correo invalido';
                              }
                            },
                            onSaved: (value) {
                              //_email = value.toString();
                              _email = bloc.email;
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 25.0, bottom: 25.0),
                        child:StreamBuilder(
                          stream: bloc.passwordStream,
                          builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                          TextFormField(
                            onChanged: bloc.changePassword,
                            obscureText: _obscureText,
                            style: const TextStyle(
                              fontSize: 17.0, color: Colors.orangeAccent),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _obscureText = !_obscureText;
                                },
                                child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off
                                ),
                              ),
                              icon: const Icon(Icons.lock,
                                color: Color(0xFF102639)
                              ),
                              labelText: 'Contraseña'
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Contraseña muy corta';
                              }
                            },
                            onSaved: (value) {
                              //_password = value.toString();
                              _password = bloc.password;
                            },
                          ),
                        ),
                      ), 
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(240.0, 50.0)),
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFefefef)),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.email, color: Colors.red),
                  label: const Text("Ingresar desde Google",
                    style: TextStyle(color: Color(0xFF727272),
                      fontSize: 18.0
                    ),
                  )
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 22.0),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 220.0, bottom: 50.0),
                  child: StreamBuilder(
                    stream: bloc.loginValidStream,
                    builder: 
                        (BuildContext context, AsyncSnapshot snapshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: MaterialButton(
                          minWidth: 60.0,
                          height: 60.0,
                          color: const Color(0xFF102639),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Map<String, dynamic> decodedResp = await _submit();
                            mainProvider.token = decodedResp['jwt'];
                            mainProvider.nombre = decodedResp['user']["username"];
                            mainProvider.idUser = decodedResp['user']["id"];
                            //print(decodedResp['jwt']);
                            //_submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      const Text("¿Nuevo miembro?",
                        style: TextStyle(color: Color(0xFF727272))
                      ),
                      MaterialButton(
                        height: 40,
                        child: const Text("Inscríbete",
                          style: TextStyle(color: Color(0xFF102639)),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UsuarioRegister(),
                            )
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    ));
  }

  /*_loadDarkModePrefs() async {
    darkModePrefs = await getDarkMode();
    setState(() {});
  }*/

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Ha ocurrido un Error',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
