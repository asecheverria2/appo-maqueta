import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:appo_lab/src/models/exam_model.dart';
import 'package:provider/provider.dart';

class TablaCard extends StatelessWidget {
  const TablaCard({Key? key, required this.model}) : super(key: key);
  final Examenes model;

  @override
  Widget build(BuildContext context) {
    final url = model.img!.toString();
    final mainProvider = Provider.of<MainProvider>(context);
    //mainProvider.getPreferences();
    final prioridad = Container(
        height: 32.0,
        width: 38.0,
        color: model.price == 3.5
            ? Colors.red
            
            : model.price == 2.25
                ? Colors.yellow
                : Colors.green,
        child: Center(child:  model.price == 3.5
          ? Text("\$"+model.price.toString(),style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)

          : Text("\$"+model.price.toString(),style: TextStyle(color: model.price == 5 ? Colors.black : Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ) 
        
    );

    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: InkWell(
        onTap: () {
          mainProvider.addexamns=model.id.toString();
          mainProvider.sum=model.price!;
          Navigator.pop(context);
        },
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(url)),
          title: Text(
            model.name.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          
          //subtitle: Text(model.description ?? ""),
          trailing: model.price == null 
                          ? null
                          : prioridad,
        ),
      ),
    );
  }
}