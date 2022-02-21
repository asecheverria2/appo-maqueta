import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:appo_lab/src/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appo_lab/src/pages/usuario_page.dart';
import 'package:appo_lab/src/pages/cita_page.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  //int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFFFFFF),
        elevation: 0,
        title: const Text(
          "Bienvenido!", 
          style: TextStyle(color: Color(0xFF787878)),),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {
                  mainProvider.token = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    )
                  );
                }, 
                icon: const Icon(Icons.person_rounded),
                iconSize: 35,
                )
            ],
          ),
          Container(
            //color: Color(0xFF787878),
            /*width: double.infinity,
            height: double.infinity,*/
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height-131,
            width: 450,
            decoration: const BoxDecoration(
              color: Color(0xFF102639), 
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            //alignment: Alignment.topCenter,
            child: Column(
              children: [
                Title(
                  color: Colors.white,
                  child: const Text(
                    'Selecciona una opción',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                            const CitaPage(),
                          ),
                      );
                    },
                    child: Row(
                      children: [
                      SizedBox(
                        height: 115.h,
                        width: 115.h,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/images/cita-medica.png'),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 40.0),
                        margin: const EdgeInsets.only(left: 75.0),
                        child: Column(
                          children: const [
                            Text("Crear Cita",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text("Aqui puede crear",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            Text("una nueva cita",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    ),
                    
                  ),
                ),
                Card(
                  margin: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          height: 115.h,
                          width: 115.h,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset('assets/images/document.png'),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 39.5),
                          margin: const EdgeInsets.only(left: 75.0),
                          child: Column(
                            children: const [
                              Text("Ver Citas",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              Text("agendadas",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),

                              Text("Aqui puede ver",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              Text("las citas agendas",
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                            const UsuarioPage(),
                          ),
                      );
                    },
                    child: Row(
                      children: [
                      SizedBox(
                        height: 115.h,
                        width: 115.h,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset('assets/images/usuario.png'),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 25.5),
                        margin: const EdgeInsets.only(left: 65.0),
                        child: Column(
                          children: const [
                            Text("Editar Perfil",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text("Aqui puede editar la",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            Text("infomación personal",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ]
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}