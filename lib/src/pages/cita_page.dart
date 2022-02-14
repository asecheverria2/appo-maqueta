import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CitaPage extends StatelessWidget {
  const CitaPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cita nueva"),
        backgroundColor: const Color(0xFF102639),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(15),
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
            Container(
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
            Container(
              margin: const EdgeInsets.only(left: 20, top:5, right: 20, bottom: 5),
              child: const Divider(
                color: Colors.grey
              ),
            ),
            Container(
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
                    Text("    Fecha y Hora",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                  ],
                ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top:6, right: 20, bottom: 5),
              child: const Divider(
                color: Colors.grey
              ),
            ),
          ],
        ),
        
      ),
    );
        
  }
}