import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CategoriesPageView extends GetView<CategoriesPageController> {
  const CategoriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return GetRouterOutlet.builder(
    //   routerDelegate: Get.rootDelegate,
    //   builder: (context, delegate, currentRoute) {
    //     return controller.obx((state) {
    //       return Scaffold(
    //           body: GetRouterOutlet(
    //               initialRoute: Routes.PROFILE, delegate: delegate),
    //           bottomNavigationBar: BottomBarButtons(
    //               onTapOnBottomBar: (value) {
    //                 controller.updateTabIndex(value);
    //                 switch (value) {
    //                   case 0:
    //                     delegate.toNamed(Routes.VOTE,
    //                         arguments: state?.data.nextQuestion);
    //                     break;
    //                   case 1:
    //                     delegate.toNamed(Routes.PROFILE);
    //                     break;
    //                   default:
    //                 }
    //               },
    //               currentIndex: state?.pageIndex ?? DEFAULT_OPENED_PAGE_INDEX));
    //     },
    //         onLoading: Container(
    //             color: BACKGROUND,
    //             child: const SpinKitDoubleBounce(color: Colors.blue)));
    //   },
    // );
  }
}