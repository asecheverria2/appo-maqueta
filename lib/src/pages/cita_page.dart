import 'package:appo_lab/src/models/cita_model.dart';
import 'package:appo_lab/src/pages/catalogo_page.dart';
import 'package:appo_lab/src/pages/menu_page.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:appo_lab/src/services/cita_services.dart';
import 'package:appo_lab/src/widgets/date_widget.dart';
import 'package:appo_lab/src/widgets/examen2_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appo_lab/src/widgets/geolocalizacion_widget.dart';
import 'package:provider/provider.dart';

class CitaPage extends StatefulWidget {
  const CitaPage({Key? key})
      : super(key: key);

  @override
  State<CitaPage> createState() => _CitaPageState();
}

class _CitaPageState extends State<CitaPage> {
  late Cita _cita;
  final CitaService _citaService = CitaService();
  @override
    void initState() {
      _cita = Cita();
      //_usuario2 = UsuarioDatos();
      super.initState();
       //_downloadContent();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    mainProvider.getPreferences();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cita nueva", 
          style: TextStyle(color: Color(0xFF102639))
        ),
        backgroundColor: const Color(0xFFf9f9f9),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 15, top: 1, right: 15, bottom: 10),
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFeaeaea),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: 
                SizedBox(
                  height: 115.h,
                  width: 115.h,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset('assets/images/cita-medica.png'),
                  ),
                ),
            ),
            InkWell(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                    const GeoWidget(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 0,left: 20, right: 20),
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFe298dd),
                      Color(0xFFc076e2),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.25, 0.90],
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.person_pin_circle),
                    Text("    Ubicación",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 3, right: 20, bottom: 3),
              child: const Divider(
                color: Colors.grey
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                    const DatePage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 0,left: 20, right: 20),
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFe298dd),
                      Color(0xFFc076e2),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.25, 0.90],
                  ),
                ),
                child: 
                  Row(
                    children: const [
                      Icon(Icons.calendar_today),
                      Text("    Fecha",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                    ],
                  ),
              ),
            ),
            
            Container(
              margin: const EdgeInsets.only(left: 20, top:3, right: 20, bottom: 3),
              child: const Divider(
                color: Colors.grey
              ),
            ),
            Container(
              //alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20),
              child: Row(
                children:  [
                  const Text("Exámenes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  StreamBuilder(
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: MaterialButton(
                          minWidth: 55.0,
                          height: 55.0,
                          color: const Color(0xFF102639),
                          child: const Icon(
                            Icons.plus_one,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                const CatalogoPage(),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 15),
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFF102639),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListView(
                children: 
                  mainProvider.exams.map((e) => TablaCard2(id: e)).toList())
            ),
            
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 14),
              child: Row(
                children: [
                    const Text("Total Cotización",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Text("USD "+mainProvider.suma.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    )
                    
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (mainProvider.date==""||mainProvider.suma<=0||mainProvider.labo=="") {
                  _showerrorDialog('Revise si ha ingresado bien Todos los datos\nNo se guardó la cita');
                } else {
                  _cita.date=DateTime.parse(mainProvider.date) ;
                  _cita.quotation= mainProvider.suma;
                  _cita.user=mainProvider.idUser;
                  _cita.lab=mainProvider.labo;
                  _cita.exams=mainProvider.examns;
                  mainProvider.examns=[];
                  mainProvider.updateLabo("");
                  mainProvider.date="";
                  mainProvider.suma=0;
                  mainProvider.updateSum(0);

                  _sendForm();
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                      const MenuPage(),
                    ),
                  );
                }
                
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 0,left: 30, right: 30),
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xFF102639),
                ),
                child: const Text("Next",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
        
      ),
    );
        
  }
  _sendForm() async {
    int estado = await _citaService.postCita(_cita);
    estado=estado;
    //print(estado);
  }
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