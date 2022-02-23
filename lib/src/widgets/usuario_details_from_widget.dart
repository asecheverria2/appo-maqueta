import 'dart:io';

import 'package:appo_lab/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appo_lab/src/models/usuario_data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appo_lab/src/services/usuario_service.dart';

class UsuarioDetailsFormWidget extends StatefulWidget {
  const UsuarioDetailsFormWidget({Key? key})
      : super(key: key);

  @override
  State<UsuarioDetailsFormWidget> createState() =>
      _UsuarioDetailsFormWidgetState();
}

class _UsuarioDetailsFormWidgetState
    extends State<UsuarioDetailsFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late UsuarioDatos _usuario;
  //late UsuarioDatos _usuario2;
  File? _imagen;
  final ImagePicker _picker = ImagePicker();
  bool _onSaving = false;
  final UsuarioService _usuarioService = UsuarioService();

  
  @override
  void initState() {
    _usuario = UsuarioDatos();
    //_usuario2 = UsuarioDatos();
    super.initState();
     //_downloadContent();
  }

  @override
  Widget build(BuildContext context) {
    /*final mainProvider = Provider.of<MainProvider>(context);
    _usuarioService.getDatos(mainProvider.idUser).then((value) {
      late UsuarioDatos _usuario2 = value;
      setState(() {});
      });*/
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: size.width * .90,
          child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Text("Perfil",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    SizedBox(
                      height: 100.h,
                      width: 150.h,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: 
                            _imagen == null
                            ? Image.asset('assets/images/usuarios.jpeg')
                            : Image.file(_imagen!),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFF102639)),
                            ),
                            onPressed: () => _selectImage(ImageSource.camera),
                            icon: const Icon(Icons.camera),
                            label: const Text("Cámara")
                            ),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFF102639)),
                            ),
                            onPressed: () => _selectImage(ImageSource.gallery),
                            icon: const Icon(Icons.image),
                            label: const Text("Galería")),
                      ],
                    ),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: _usuario.nombre,
                        onSaved: (value) {
                          //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                          _usuario.nombre = value.toString();
                        },
                        validator: (value) {
                          return _validateObservacion(value!);
                        },
                        decoration: const InputDecoration(
                            icon:  Icon(Icons.person, color: Color(0xFF102639)),
                            labelText:"Nombre",
                          ),
                            
                        maxLength: 50
                        ),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: _usuario.numero,
                        onSaved: (value) {
                          //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                          _usuario.numero = value.toString();
                        },
                        validator: (value) {
                          return _validateObservacion(value!);
                        },
                        decoration: const InputDecoration(
                            icon: Icon(Icons.phone, color: Color(0xFF102639)),
                            labelText: "Número de teléfono"),
                        maxLength: 50
                        ),
                    
                    TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: _usuario.direccion,
                        onSaved: (value) {
                          //Este evento se ejecuta cuando se cumple la validación y cambia el estado del Form
                          _usuario.direccion = value.toString();
                        },
                        validator: (value) {
                          return _validateObservacion(value!);
                        },
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person_pin_circle, color: Color(0xFF102639)),
                            labelText: "Dirección"),
                        maxLength: 50
                        ),
                    _onSaving
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Tooltip(
                              message: "Registrar usuario",
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    _sendForm();
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ));
                                  },
                                  label: const Text("Guardar"),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(const Color(0xFF102639)),
                                  ),
                                  icon: const Icon(Icons.save)),
                            ),
                          )
                  ],
                ),
              )),
        )
      ],
    ));
  }

  Future _selectImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _imagen = File(pickedFile.path);
    } else {
      _imagen = null;
      //print('No image selected.');
    }
    setState(() {});
  }

  _sendForm() async {
    if (!_formKey.currentState!.validate()) return;
    _onSaving = true;
    setState(() {});

    //Vincula el valor de las controles del formulario a los atributos del modelo
    _formKey.currentState!.save();

    if (_imagen != null) {
      _usuario.img = await _usuarioService.uploadImage(_imagen!);
    }

    //Invoca al servicio POST para enviar el Usuario
    int estado = await _usuarioService.postUsuario(_usuario);
    if (estado == 201) {
      _formKey.currentState!.reset();
      _onSaving = false;
      _formKey.currentState!.setState(() {});
      setState(() {});
    }
  }

  String? _validateObservacion(String value) {
    return (value.length < 5)
        ? "Debe ingresar un mensaje con al menos 25 caracteres"
        : null; //Validación se cumple al retorna null
  }
  /*_downloadContent(){
    _usuarioService.getDatos().then((value) {
      _catalogo = value;
      setState(() {});
      });
  }*/
}
