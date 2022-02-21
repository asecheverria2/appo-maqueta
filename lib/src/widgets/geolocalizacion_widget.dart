import 'dart:async';

import 'package:appo_lab/src/models/lab_model.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:appo_lab/src/services/lab_services.dart';
import 'package:appo_lab/src/widgets/lab_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GeoWidget extends StatefulWidget {
  const GeoWidget({Key? key}) : super(key: key);

  @override
  
  _GeoWidgetState createState() => _GeoWidgetState();
}

class _GeoWidgetState extends State<GeoWidget> {

  final LaboratorioService _apiService = LaboratorioService();
  List<Laboratorio> _catalogo = [];
  List<Laboratorio>? _catalogo2;

  Set<Marker> _lab = Set<Marker>(); 
  
  @override
  void initState() {
    super.initState();
    _downloadContent();
  }

  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(-0.935198, -78.616465),
    zoom: 15.4746,
  );

  /*final CameraPosition _kLake = const CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414
  );*/

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    /*Set<Marker> _lab = _catalogo!
      .map<Marker>((e){
      Laboratorio model = e;
      LatLng(model.latitude ?? -0.935198, model.longitude ?? -78.616465);
      return Marker(markerId: MarkerId(model.id!));
    }).toSet();*/
    

    var tit = _catalogo2 == null ? 
    [const Center(
      child: SizedBox(
        height: 50, width: 50.0, child: CircularProgressIndicator()),
      ),]
    : _catalogo2!.isEmpty ?
      [const Center(
        child: SizedBox(child : Text('No hay Laboratorios')),
      ),]
    : _catalogo2!.map((e) => TablaCard(model: e,)).toList();
    var nom = [    
      const Text("Seleccione un laboratorio",
                  style: TextStyle(color: Colors.white),
                ), 
      const Padding(padding: EdgeInsets.only(bottom: 30.0)),
      Container(
                  padding: const EdgeInsets.only(left: 20, top: 3, right: 20),
                  height: 207,
                  width: 800,
                  decoration: const BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  ),
            child: _catalogo2 == null ? 
              const Center(
                child: SizedBox(
                  height: 50, width: 50.0, child: CircularProgressIndicator()),
                )
              : _catalogo2!.isEmpty ?
                const Center(
                  child: SizedBox(child : Text('No hay Laboratorios')),
                )
              :ListView(
                children:_catalogo2!.map((e) => TablaCard(model: e,)).toList(),
                ))
    ];
    var newList = [...nom];
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-283,
            child: GoogleMap(
              markers: _lab,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _addMarker();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            height: 283,
            width: 800,
            decoration: const BoxDecoration(
              color: Color(0xFF102639), 
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            child: Column(
                children: newList 
                  ),
                ),
              ],
            ),
          );
  }
  Future<void> _addMarker() async {
    // ignore: unused_local_variable
    GoogleMapController controller = await _controller.future;
    // ignore: avoid_function_literals_in_foreach_calls
    _catalogo.forEach((element) { 
      setState(() {
        _lab.add(
          Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            markerId: MarkerId(element.id.toString()),
            infoWindow: InfoWindow(title: element.name),
            position: LatLng(element.latitude!.toDouble(), element.longitude!.toDouble()),
          ),
        );
      });
    }); 
  }
  _downloadContent(){
    _apiService.getLaboratorio().then((value) {
      _catalogo = value;
      _catalogo2=value;
      setState(() {});
    });
  }
  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
