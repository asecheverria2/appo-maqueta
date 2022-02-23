import 'package:appo_lab/src/models/cita_model.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitaCard extends StatelessWidget {
  const CitaCard({Key? key, required this.model}) : super(key: key);
  final Cita model;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    //mainProvider.getPreferences();
    final prioridad = Container(
        height: 32.0,
        width: 38.0,
        color: model.quotation == 3.5
            ? Colors.red
            
            : model.quotation == 2.25
                ? Colors.yellow
                : Colors.green,
        child: Center(child:  model.quotation == 3.5
          ? Text("\$"+model.quotation.toString(),style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)

          : Text("\$"+model.quotation.toString(),style: TextStyle(color: model.quotation == 5 ? Colors.black : Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ) 
        
    );

    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: InkWell(
        /*onTap: () {
          mainProvider.addexamns=model.id.toString();
          mainProvider.sum=model.price!;
          Navigator.pop(context);
        },*/
        child: ListTile(
          //leading: CircleAvatar(backgroundImage: NetworkImage(url)),
          title: Text(
            model.lab2!.name.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          
          //subtitle: Text(model.description ?? ""),
          trailing: model.quotation == null 
                          ? null
                          : prioridad,
        ),
      ),
    );
  }
}