import 'package:appo_lab/src/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

class OnboarWidget extends StatelessWidget {
  OnboarWidget({Key? key}) : super(key: key);

  final onboardingPagesList = [
    PageModel(
      widget: Column(
        children: [
          Container(
            width: 1000,
            color: const Color(0xFF102639),
            padding: const EdgeInsets.only(bottom: 45.0),
            child: Image.asset('assets/images/consulta.png')
          ),
          const Padding(padding: EdgeInsets.only(bottom: 15.0)),
          Container(
              child: const Text('La salud de tu familia es prioridad nuestra!', 
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ), 
              )
            ),
          const Padding(padding: EdgeInsets.only(bottom: 15.0)),
          Container(
            width: double.infinity,
            child: const Text(
              'Agenda tus citas',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Container(
            width: 500,
            color: const Color(0xFF102639),
            child: Image.asset('assets/images/quimica.png'),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 15.0)),
          const Text('Aquí realizamos exámenes al mejor precio', 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 15.0)),
          const Text(
            'No dudes en ocupar nuestros servicios',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          )
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Container(
            width: 500,
            color: const Color(0xFF102639),
            child: Image.asset('assets/images/seguro-de-salud.png'),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 25.0)),
          const Text('SEGURO!', 
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 15.0)),
          const Text(
            'Resultados seguros',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  ];

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Onboarding(
        background: Colors.white,
        proceedButtonStyle: ProceedButtonStyle(
          proceedButtonColor: const Color(0xFF102639),
          proceedButtonRoute: (context) {
            return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
              (route) => false,
            );
          },
          proceedpButtonText: const Text("Iniciar sesión",
            style: TextStyle(color: Colors.white),
          ),
        ),
        pages: onboardingPagesList,
        isSkippable: false,
        indicator: Indicator(
            activeIndicator: const ActiveIndicator(color: Colors.black),
            closedIndicator: const ClosedIndicator(color: Colors.black),
            indicatorDesign: IndicatorDesign.polygon(
                polygonDesign: PolygonDesign(
                    polygon: DesignType.polygon_square, polygonSpacer: 13.0))),
      ),
    );
  }
}