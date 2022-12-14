import 'package:garbage_collector/pages/camera/binding.dart';
import 'package:garbage_collector/pages/camera/view.dart';
import 'package:garbage_collector/pages/categories/binding.dart';
import 'package:garbage_collector/pages/categories/view.dart';
import 'package:garbage_collector/pages/info/binding.dart';
import 'package:garbage_collector/pages/info/view.dart';
import 'package:garbage_collector/pages/main/binding.dart';
import 'package:garbage_collector/pages/main/view.dart';
import 'package:garbage_collector/pages/map/binding.dart';
import 'package:garbage_collector/pages/map/view.dart';
import 'package:garbage_collector/pages/objects/binding.dart';
import 'package:garbage_collector/pages/objects/view.dart';
import 'package:garbage_collector/pages/settings/binding.dart';
import 'package:garbage_collector/pages/settings/view.dart';
import 'package:get/get.dart';

import '../pages/node_add_form/view.dart';
import '../pages/node_add_form/binding.dart';
import '../pages/node_add_map/binding.dart';
import '../pages/node_add_map/view.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Paths.main,
        page: () => MainPageView(),
        binding: MainPageBinding(),
        children: [
          GetPage(
              name: Paths.camera,
              page: () => CameraPageView(),
              binding: CameraPageBinding(),
              transition: Transition.noTransition,
              children: [
                GetPage(
                  name: Paths.info,
                  page: () => InfoPageView(),
                  binding: InfoPageBinding(),
                  transition: Transition.upToDown,//noTransition,
                )
              ]),
          GetPage(
              name: Paths.categories,
              page: () => CategoriesPageView(),
              binding: CategoriesPageBinding(),
              transition: Transition.noTransition,
              children: [
                GetPage(
                    name: Routes.info,
                    page: () => InfoPageView(),
                    binding: InfoPageBinding(),
                    transition: Transition.upToDown)
              ]),
          GetPage(
              name: Paths.map,
              page: () => MapPageView(),
              binding: MapPageBinding(),
              transition: Transition.noTransition),
          GetPage(
              name: Paths.nodeAddMap,
              page: () => NodeAddMapPageView(),
              binding: NodeAddMapPageBinding(),
              transition: Transition.noTransition),
          GetPage(
              name: Paths.nodeAddForm,
              page: () => NodeAddFormPageView(),
              binding: NodeAddFormPageBinding(),
              transition: Transition.noTransition),
          GetPage(
            name: Paths.settings,
            transition: Transition.noTransition,
            page: () => SettingsPageView(),
            binding: SettingsPageBinding(),
          )
        ]),
  ];
}