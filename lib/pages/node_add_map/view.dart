import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

import 'controller.dart';
import 'package:garbage_collector/navigation/routes.dart';

class NodeAddMapPageView extends GetView<NodeAddMapPageController> {
  static const double _MARKER_SIZE = 40;
  static const double _MAP_ZOOM = 15;

  const NodeAddMapPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Location')),
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
                            maxZoom: 18,
                            onTap: _handleTap),
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
                                builder: (ctx) => Container(
                                      key: const Key('red'),
                                      child: const Icon(Icons.my_location_sharp,
                                          color: Colors.blue,
                                          size: _MARKER_SIZE),
                                    )),
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
  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    Get.toNamed(Routes.nodeAddForm, arguments: latlng);
  }
}
