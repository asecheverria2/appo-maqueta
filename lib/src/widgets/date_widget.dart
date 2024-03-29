//import 'dart:html';

import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:intl/intl.dart';
import '../../utils.dart';
import 'package:intl/intl.dart';
//import 'dart:collection';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key})
      : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _diaActual = DateTime.now();
  DateTime? _diaSeleccionado;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    mainProvider.getPreferences();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fecha',
          style: TextStyle(color: Color(0xFF102639))
        ),
        backgroundColor: const Color(0xFFf9f9f9),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body:Column(
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _diaActual,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_diaSeleccionado, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_diaSeleccionado, selectedDay)) {
                setState(() {
                  _diaSeleccionado = selectedDay;
                  _diaActual = focusedDay;
                });
                mainProvider.date= dateFormat.format(selectedDay);
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _diaActual = focusedDay;
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 150.0)),
          InkWell(
              onTap: () {
                Navigator.pop(context);
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
                child: const Text("Guardar",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
        ],
      ) 
      
    );
  }
}