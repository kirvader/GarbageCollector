import 'package:get/get.dart';
import 'package:location/location.dart';

import 'state.dart';

class NodeAddFormPageController extends GetxController with StateMixin<NodeAddFormPageState> {
  final currentLocation = Location().getLocation().obs;
}
