import 'package:appo_lab/src/models/lab_model.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablaCard extends StatelessWidget {
  const TablaCard({Key? key, required this.model}) : super(key: key);
  final Laboratorio? model;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    
     mainProvider.getPreferences();
    return InkWell(
      onTap: () {
        mainProvider.labo = model!.id.toString();
        Navigator.pop(context);
        print("lab "+mainProvider.labo);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 0,left: 20, right: 20, bottom: 5),
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
          children: [
            const Icon(Icons.storefront,
              color: Colors.white
            ),
            Text(
              model!.name.toString(),
              style: const TextStyle(
                color: Colors.white
              ),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}