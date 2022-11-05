import 'dart:convert';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'state.dart';

class MapPageController extends GetxController with StateMixin<MapPageState> {
  final currentLocation = Location().getLocation().obs;

  var tag;

  MapPageController() {
    if (Get.arguments != null) {
      tag = Get.arguments.toString();
    }
  }

  Future<List<Node>> getRecyclePoints({double range = 0.1 }) async {
    var center = (await currentLocation.value);
    var param = '"amenity"="recycling"';
    if(tag != null) {
      param = '"$tag"="yes"';
    }
    final response = await http.post(Uri.parse('https://overpass-api.de/api/interpreter'),
        headers: <String, String>{
          'Content-Type': 'text/plain;charset=UTF-8',
        },
        body:
        '''data=[out:json][timeout:25];
        (
          node[$param](${center.latitude! - range},${center.longitude! - range},${center.latitude! + range},${center.longitude! + range});
          way[$param](${center.latitude! - range},${center.longitude! - range},${center.latitude! + range},${center.longitude! + range});
        );
        out center;''');
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['elements'];
      return List<Node>.from(l.map((model)=> Node.fromJson(model)));
    } else {
      throw Exception('Failed get recycle points.');
    }
  }
}

class Node{
  final double latitude;
  final double longitude;

  const Node({required this.latitude, required this.longitude});

  factory Node.fromJson(Map<String, dynamic> json) {
    if(json['type'] == 'way') {
      return Node(
        latitude: json['center']['lat'],
        longitude: json['center']['lon'],
      );
    } else {
      return Node(
        latitude: json['lat'],
        longitude: json['lon'],
      );
    }
  }
}
