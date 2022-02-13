import 'package:flutter/material.dart';
import 'package:appo_lab/src/utils/enums.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFFFFFFF),
        elevation: 0,
        title: const Text(
          "Bienvenido!", 
          style: TextStyle(color: Color(0xFF787878)),),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            children: const [
              Spacer(),
              IconButton(
                onPressed: null, 
                icon: Icon(Icons.people_alt_rounded),
                iconSize: 35,
                )
            ],
          ),
          Container(
            //color: Color(0xFF787878),
            /*width: double.infinity,
            height: double.infinity,*/
            padding: EdgeInsets.all(20),
            height: 550,
            width: 450,
            decoration: const BoxDecoration(
              color: Color(0xFF102639), 
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            //alignment: Alignment.topCenter,
            child: Title(
              color: Colors.white,
              child: const Text(
                'Selecciona una opción',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}