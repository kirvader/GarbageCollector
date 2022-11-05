import 'package:get/get.dart';

import 'controller.dart';

class SettingsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsPageController>(() => SettingsPageController());
  }
}