import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'controller.dart';

class MapPageView extends GetView<MapPageController> {
  static const double _MARKER_SIZE = 40;
  static const double _MAP_ZOOM = 15;
  static const double _MAP_BOUNDS_OFFSET = 0.13;

  const MapPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var markerLayer = FutureBuilder(
        future: getMarkers(),
        builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
          if (snapshot.hasData) {
            return MarkerLayer(markers: snapshot.data!);
          } else {
            return const MarkerLayer();
          }
        });
    return Scaffold(
      appBar: AppBar(title: const Text('Closest Recycle Points'),
          leading: BackButton(
              color: Colors.white
          )),
      body: Column(
        children: [
          Flexible(
            child: Obx(() {
              return FutureBuilder(
                  future: controller.currentLocation.value,
                  builder: (BuildContext context,
                      AsyncSnapshot<LocationData> snapshot) {
                    if (snapshot.hasData) {
                      return FlutterMap(
                        options: MapOptions(
                            center: LatLng(snapshot.data!.latitude!,
                                snapshot.data!.longitude!),
                            interactiveFlags: InteractiveFlag.pinchZoom |
                                InteractiveFlag.drag,
                            maxBounds: LatLngBounds(
                                LatLng(
                                    snapshot.data!.latitude! -
                                        _MAP_BOUNDS_OFFSET,
                                    snapshot.data!.longitude! -
                                        _MAP_BOUNDS_OFFSET),
                                LatLng(
                                    snapshot.data!.latitude! +
                                        _MAP_BOUNDS_OFFSET,
                                    snapshot.data!.longitude! +
                                        _MAP_BOUNDS_OFFSET)),
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
                          markerLayer,
                          MarkerLayer(markers: [
                            Marker(
                              width: _MARKER_SIZE,
                              height: _MARKER_SIZE,
                              point: LatLng(snapshot.data!.latitude!,
                                  snapshot.data!.longitude!),
                              builder: (ctx) => Container(
                                key: const Key('red'),
                                child: const Icon(Icons.my_location_sharp,
                                    color: Colors.blue, size: _MARKER_SIZE),
                              ),
                            )
                          ])
                        ],
                      );
                    } else {
                      return Container();
                    }
                  });
            }),
          ),
        ],
      ),
    );
  }

  Future<List<Marker>> getMarkers() async {
    final nodes = await controller.getRecyclePoints();
    return List<Marker>.from(nodes.map((node) => Marker(
          width: _MARKER_SIZE,
          height: _MARKER_SIZE,
          point: LatLng(node.latitude, node.longitude),
          builder: (ctx) => GestureDetector(
              onTap: () {
                MapsLauncher.launchCoordinates(node.latitude, node.longitude);
              },
              child: Container(
                key: const Key('red'),
                child: const Icon(Icons.location_on_sharp,
                    color: Colors.red, size: _MARKER_SIZE),
              )),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        )));
  }
}
