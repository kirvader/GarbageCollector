import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import 'controller.dart';
import 'package:garbage_collector/navigation/routes.dart';

class NodeAddFormPageView extends GetView<NodeAddFormPageController> {
  static const double _MARKER_SIZE = 40;
  static const double _MAP_ZOOM = 16;

  const NodeAddFormPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final coords = Get.arguments as LatLng;
    return Scaffold(
        appBar: AppBar(title: const Text('Recycle Point Details'),
            leading: BackButton(
                color: Colors.white
            )),
        body: Column(children: [
          Flexible(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                          center: coords,
                          interactiveFlags: 0,
                          zoom: _MAP_ZOOM,
                          maxZoom: 18),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          tileProvider: NetworkTileProvider(),
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            width: _MARKER_SIZE,
                            height: _MARKER_SIZE,
                            point: coords,
                            builder: (ctx) => Container(
                              key: const Key('red'),
                              child: const Icon(Icons.location_on_sharp,
                                  color: Colors.red, size: _MARKER_SIZE),
                            ),
                          )
                        ])
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          labelText: 'Tags'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                            labelText: 'Description'
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Form was submitted!",  // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.BOTTOM,    // location
                            timeInSecForIosWeb: 1
                          );
                          Get.offAllNamed(Paths.main);
                        },
                        child: Text("Submit"))
                  ]),
                )
              ],
            ),
          )
        ]));
  }
}
