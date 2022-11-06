import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garbage_collector/pages/info/models/categories.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../navigation/routes.dart';

class InfoView extends StatelessWidget {
  final String categoryName;
  final String header;
  final String description;
  final List<String> tags;

  const InfoView(
      {Key? key,
      required this.header,
      required this.description,
      required this.tags,
      required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String iconName = categoryName
        .toLowerCase()
        .replaceAll(RegExp("[- /]"), "_");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Center(
        child: SvgPicture.asset('assets/icons/$iconName.svg',
            color: Colors.blue,
            semanticsLabel: categoryName,
            height: 200,
            width: 200,
            fit: BoxFit.fill),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(header.toUpperCase(),
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(description, style: const TextStyle(fontSize: 20)),
      ),
      const Spacer(),
      Container(
        height: 150,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.map, arguments: tags);
            },
            style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(3.0),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            child: const Text("Find nearest place to hand it over",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
      )
    ]);
  }
}
