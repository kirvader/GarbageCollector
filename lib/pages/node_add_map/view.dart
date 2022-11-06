import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import 'controller.dart';
import 'package:garbage_collector/navigation/routes.dart';

class NodeAddMapPageView extends GetView<NodeAddMapPageController> {
  static const double _MARKER_SIZE = 40;
  static const double _MAP_ZOOM = 15;

  const NodeAddMapPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              point: LatLng(snapshot.data!.latitude!,
                                  snapshot.data!.longitude!),
                              builder: (ctx) => GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Paths.nodeAddForm,
                                        arguments: LatLng(
                                            snapshot.data!.latitude!,
                                            snapshot.data!.longitude!));
                                  },
                                  child: Container(
                                    key: const Key('red'),
                                    child: const Icon(Icons.my_location_sharp,
                                        color: Colors.blue, size: _MARKER_SIZE),
                                  )),
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
}
