import 'package:garbage_collector/features/utils/recognition_result.dart';
import 'package:garbage_collector/pages/camera/state.dart';
import 'package:get/get.dart';


class CameraPageController extends GetxController with StateMixin<CameraPageState> {
  var info = "".obs;

  void updateInfo(List<Recognition> recognitions) {
    for (var result in recognitions) {
      info.value += result.toString();
      info.value += '\n';
    }
    info.refresh();
  }
}