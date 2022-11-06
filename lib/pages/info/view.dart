import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garbage_collector/pages/info/controller.dart';
import 'package:garbage_collector/pages/info/info_view.dart';
import 'package:get/get.dart';


class InfoPageView extends GetView<InfoPageController> {
  const InfoPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments as Map<String, dynamic>;
    var tags = arguments["tags"] as List<String>;
    var header = arguments["header"] as String;
    var category = arguments["categoryName"] as String;

    return Scaffold(
          body: FutureBuilder(
        future: fetchDescription(category, context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Container();
          }
          var description = snapshot.data;
          return SafeArea(
              child: InfoView(
                  categoryName: category,
                  description: description,
                  header: header,
                  tags: tags));
        },
      ));
  }

  dynamic loadJSON(String jsonPath, BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString(jsonPath);
    final jsonResult = jsonDecode(data);
    return jsonResult;
  }

  Future<String> fetchDescription(String categoryName, BuildContext context) async {
    var categoriesDescriptions =
    await loadJSON("assets/categories.json", context);

    return categoriesDescriptions[categoryName];
  }
}
