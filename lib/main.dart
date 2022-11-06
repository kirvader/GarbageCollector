import 'package:flutter/material.dart';
import 'package:garbage_collector/navigation/pages.dart';
import 'package:garbage_collector/navigation/routes.dart';
import 'package:get/get.dart';

ThemeData getTheme() {
  return ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white);
}

void main() {
  runApp(GetMaterialApp(
    initialRoute: Routes.main,
    theme: getTheme(),
    getPages: AppPages.pages,
    enableLog: true,
  ));
}
