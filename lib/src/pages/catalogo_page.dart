import 'package:appo_lab/src/models/exam_model.dart';
import 'package:appo_lab/src/services/exam_services.dart';
import 'package:appo_lab/src/widgets/examen_card.dart';
import 'package:appo_lab/src/widgets/login_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:flutter/material.dart';

//import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({Key? key}) : super(key: key);

  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  final ExamenesService _apiService = ExamenesService();
  List<Examenes>? _catalogo;

  @override
  void initState() {
    super.initState();
    _downloadContent();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.square(
          dimension: 60.0,
              child: FlutterSwitch(
                      width: 60.0,
                      height: 30.0,
                      toggleSize: 30.0,
                      value: mainProvider.mode,
                      borderRadius: 30.0,
                      padding: 0.0,
                      activeToggleColor: const Color(0xFF6E40C9),
                      inactiveToggleColor: const Color(0xFF2F363D),
                      activeSwitchBorder: Border.all(
                        color: const Color(0xFF3C1E70),
                        width: 6.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: const Color(0xFFD1D5DA),
                        width: 6.0,
                      ),
                      activeColor: const Color(0xFF271052),
                      inactiveColor: Colors.white,
                      activeIcon: const Icon(
                        Icons.wb_sunny,
                        color: Color(0xFFFFDF5D),
                      ),
                      inactiveIcon: const Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFF8E3A1),
                      ), onToggle: (bool value) async{  
                        mainProvider.mode = value;
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool("mode", value);
                      },
                    )
        ),
        title: const Text('Exámenes Disponibles')
      ),
      drawer: Drawer(child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
              },
              child: Text(
                'Salir',
                style: Theme.of(context).textTheme.headline6,
              )),),
      body: _catalogo == null ? 
    const Center(
      child: SizedBox(
        height: 50, width: 50.0, child: CircularProgressIndicator()),
      )
    : _catalogo!.isEmpty ?
      const Center(
        child: SizedBox(child : Text('No hay datos de los Examenes')),
      )
    : Container(
      padding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 7.0),
      child: ListView(
          children: 
            _catalogo!.map((e) => TablaCard(model: e,)).toList())),
    );
  }

  _downloadContent(){
    _apiService.getExamen().then((value) {
      _catalogo = value;
      setState(() {});
      });
  }
}