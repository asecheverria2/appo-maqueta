import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoWidget extends StatefulWidget {
  const GeoWidget({Key? key}) : super(key: key);

  @override
  State<GeoWidget> createState() => _GeoWidgetState();
}

class _GeoWidgetState extends State<GeoWidget> {

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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400.0,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
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
              children:  [
                const Text("Seleccione un laboratorio",
                  style: TextStyle(color: Colors.white),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30.0)),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 23, right: 20),
                  height: 207,
                  width: 800,
                  decoration: const BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          /*Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                              const GeoWidget(),
                            ),
                          );*/
                          //print("");
                        },
                        child: Container(
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
                          child: Row(
                            children: const [
                              Icon(Icons.storefront,
                                color: Colors.white
                              ),
                              Text("    Laboratorio 1",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 6.0)),
                      InkWell(
                        onTap: () {
                          /*Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                              const GeoWidget(),
                            ),
                          );*/
                          //print("");
                        },
                        child: Container(
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
                          child: Row(
                            children: const [
                              Icon(Icons.storefront,
                                color: Colors.white
                              ),
                              Text("    Laboratorio 2",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 6.0)),
                      InkWell(
                        onTap: () {
                          /*Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                              const GeoWidget(),
                            ),
                          );*/
                          //print("");
                        },
                        child: Container(
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
                          child: Row(
                            children: const [
                              Icon(Icons.storefront,
                                color: Colors.white
                              ),
                              Text("    Laboratorio 3",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }
  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
