import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePage extends StatelessWidget {
  const DatePage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fecha y hora", 
          style: TextStyle(color: Color(0xFF102639))
        ),
        backgroundColor: const Color(0xFFf9f9f9),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        
      ),
    );
        
  }
}