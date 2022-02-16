import 'package:appo_lab/src/bloc/signup_bloc.dart';
import 'package:appo_lab/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:appo_lab/src/services/user_service.dart';
import 'package:appo_lab/src/widgets/login_widget.dart';

class UsuarioRegister extends StatefulWidget {
  const UsuarioRegister({Key? key}) : super(key: key);

  @override
  _UsuarioRegisterState createState() => _UsuarioRegisterState();
}

class _UsuarioRegisterState extends State<UsuarioRegister> {
  late SignUpBloc bloc;

  final UserService _userService = UserService();
  late Usuario _user;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  bool? darkModePrefs;
  @override
  void initState() {
    bloc = SignUpBloc();
    super.initState();
    /*_loadDarkModePrefs();*/
    _user = Usuario.create("", "", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf9f9f9),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
                  child: Title(
                    color: Colors.black,
                    child: const Text(
                      'Regístrate',
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
                    'Crea una cuenta aquí',
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
                          stream: bloc.usernameStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                              TextFormField(
                                onChanged: bloc.changeUsername,
                                initialValue: _user.username,
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.orangeAccent),
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.person,
                                      color: Color(0xFF102639),
                                    ),
                                    labelText: 'Ingresa tu nombre completo'),
                                onSaved: (value) {
                                  _user.username = bloc.username;
                                },
                              ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 25.0, bottom: 25.0),
                        child: StreamBuilder(
                          stream: bloc.usernameStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                              TextFormField(
                                onChanged: bloc.changeEmail,
                                initialValue: _user.email,
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.orangeAccent),
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.email,
                                      color: Color(0xFF102639),
                                    ),
                                    hintText: 'usuario@trifasic.com',
                                    labelText: 'Correo electronico'),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Correo invalido';
                                  }
                                },
                                onSaved: (value) {
                                  _user.email = bloc.email;
                                },
                              ),
                        ),
                      ), 
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 25.0, bottom: 25.0),
                        child: StreamBuilder(
                          stream: bloc.passwordStream,
                            builder: (BuildContext context,
                                    AsyncSnapshot snapshot) =>
                              TextFormField(
                                onChanged: bloc.changePassword,
                                obscureText: _obscureText,
                                initialValue: _user.password,
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.orangeAccent),
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
                                  _user.password = bloc.password;
                                },
                              ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 25.0),
                        child: const Text("Al registrarte, aceptas nuestros téminos de uso.",
                          style: TextStyle(
                            fontSize: 14.0, 
                            color: Color(0xFF102639)
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 220.0, bottom: 60.0),
                        child: StreamBuilder(
                          stream: bloc.signUpValidStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot){
                                  return Padding(
                                    padding:
                                      const EdgeInsets.symmetric(vertical: 20.0),
                                    child: MaterialButton(
                                      minWidth: 60.0,
                                      height: 60.0,
                                      color: const Color(0xFF102639),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
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
                                                        builder: (context) => const Login()));
                                              }
                                            );
                                        });
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(60.0),
                                      ),
                                    ),
                                  );
                                }
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      const Text("¿Ya eres miembro?",
                        style: TextStyle(color: Color(0xFF727272))
                      ),
                      MaterialButton(
                        height: 40,
                        child: const Text("Inicia sesión",
                          style: TextStyle(color: Color(0xFF102639)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            )
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  /*_loadDarkModePrefs() async {
    darkModePrefs = await getDarkMode();
    setState(() {});
  }*/
}
