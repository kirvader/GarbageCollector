import 'package:get/get.dart';
import 'package:location/location.dart';

import 'state.dart';

class NodeAddMapPageController extends GetxController with StateMixin<NodeAddMapPageState> {
  final currentLocation = Location().getLocation().obs;
}
