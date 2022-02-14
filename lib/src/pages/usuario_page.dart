//import 'package:appo_lab/src/services/usuario_service.dart';
import 'package:appo_lab/src/widgets/usuario_details_from_widget.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:appo_lab/src/models/usuario_model.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color(0xFF102639),
      ),
      body: 
        const UsuarioDetailsFormWidget(),
    );
        
  }
}