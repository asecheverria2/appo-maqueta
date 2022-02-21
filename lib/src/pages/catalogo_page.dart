import 'package:appo_lab/src/models/exam_model.dart';
import 'package:appo_lab/src/services/exam_services.dart';
import 'package:appo_lab/src/widgets/examen_card.dart';
//import 'package:appo_lab/src/widgets/login_widget.dart';
//import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
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
    
    var nom = [
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 10),
        child: const Text("Selecciona el tipo de examen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0
            
          ),
        ),
      ),
      
    ];

    var tit = _catalogo == null ? 
    [const Center(
      child: SizedBox(
        height: 50, width: 50.0, child: CircularProgressIndicator()),
      ),]
    : _catalogo!.isEmpty ?
      [const Center(
        child: SizedBox(child : Text('No hay datos de los Examenes')),
      ),]
    : _catalogo!.map((e) => TablaCard(model: e,)).toList();
    var newList = [...nom, ...tit];
    //nom.addAll(tit);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de exámenes',
          style: TextStyle(color: Color(0xFF102639))
        ),
        backgroundColor: const Color(0xFFf9f9f9),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      /*drawer: Drawer(child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            )
          );
        },
        child: Text(
          'Salir',
          style: Theme.of(context).textTheme.headline6,
        )
      ),),*/
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 3),
        height: MediaQuery.of(context).size.height,
        width: 450,
        decoration: const BoxDecoration(
          color: Color(0xFF102639), 
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        child: 
          _catalogo == null ? 
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
                  newList,
                )
          ),
      ),
    );
  }

  _downloadContent(){
    _apiService.getExamen().then((value) {
      _catalogo = value;
      setState(() {});
      });
  }
}