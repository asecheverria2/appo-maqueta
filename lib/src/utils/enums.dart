//import 'package:appo_lab/src/models/exam_model.dart';
import 'package:appo_lab/src/pages/catalogo_page.dart';
//import 'package:appo_lab/src/pages/home_page.dart';
import 'package:appo_lab/src/pages/usuario_page.dart';
import 'package:flutter/material.dart';
//import 'package:appo_lab/src/widgets/usuario_details_from_widget.dart';
//import 'package:appo_lab/src/widgets/examen_card.dart';

class ItemMenu {
  String label;
  IconData icon;
  ItemMenu(this.icon, this.label);
  ItemMenu.create(this.icon, this.label);
}

List<ItemMenu> menuOptions = [
  ItemMenu(Icons.home, "Catálogo"),
  ItemMenu(Icons.videocam, "Perfil")
];

List<Widget> contentWidget = const [CatalogoPage(), UsuarioPage()];

class BackgroundPage {
  static Widget getBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Theme.of(context).colorScheme.primary),
    );

    final circle_2 = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Theme.of(context).backgroundColor.withAlpha(25)),
    );

    return Stack(
      children: [
        Container(
          height: size.height * 0.4,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorDark,
          ])),
        ),
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0, left: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle_2),
        Positioned(bottom: 120.0, right: 20.0, child: circle_2),
        Positioned(bottom: -50.0, left: -20.0, child: circle_2)
      ],
    );
  }
}
