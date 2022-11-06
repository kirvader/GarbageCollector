import 'dart:convert';
import 'dart:math';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:garbage_collector/features/utils/classifier.dart';
import 'package:garbage_collector/features/utils/recognition_result.dart';

/// Individual bounding box
class BoxWidget extends StatelessWidget {
  final Recognition result;
  final Size cameraSize;
  final void Function(Map<String, dynamic>) navigateToInfo;

  const BoxWidget({super.key, required this.result, required this.cameraSize, required this.navigateToInfo});

  @override
  Widget build(BuildContext context) {

    double input_model_size = Classifier.INPUT_SIZE.toDouble();
    // Color for bounding box
    Color color = Colors.primaries[
    (result.label.length + result.label.codeUnitAt(0) + result.id) %
        Colors.primaries.length];

    double getPos(double arg, bool isHor) {
      if(isHor == (cameraSize.width > cameraSize.height)) {
        if(isHor) {
          return arg * max(cameraSize.width, cameraSize.height);
        } else {
          return arg * max(cameraSize.width, cameraSize.height) ;
        }
      } else {
        if(isHor) {
          return arg * max(cameraSize.width, cameraSize.height) - (cameraSize.height - cameraSize.width).abs() / 2;
        } else {
          return arg * max(cameraSize.width, cameraSize.height) - (cameraSize.height - cameraSize.width).abs() / 2;
        }
      }
    }

    return Positioned(
      left: result.renderLocation.left  * max(cameraSize.width, cameraSize.height),
      top: result.renderLocation.top * max(cameraSize.width, cameraSize.height),
      width: result.renderLocation.width * max(cameraSize.width, cameraSize.height) ,
      height: result.renderLocation.height * max(cameraSize.width, cameraSize.height) ,
      child: GestureDetector(
        onTap: () async {
          Map<int, String> mapping = {8 : "plastic bottle", 15: 'shoes', 21 : "glass bottle", 7 : "metal tin"};
          var clsId = result.id;
          late String header;
          if (mapping.containsKey(clsId)) {
            header = mapping[clsId]!;
          } else {
            header = "shoes";
          }
          var objectsDescriptions =
              await loadJSON("assets/objects.json", context);
          var object = objectsDescriptions[header];
          var category = object["category"];
          var tags = object["tags"];

          navigateToInfo({
            'categoryName': category,
            'tags': tags,
            'header': header
          });
        },
        child: Container(
          width: result.renderLocation.width * max(cameraSize.width, cameraSize.height) ,
          height: result.renderLocation.height * max(cameraSize.width, cameraSize.height) ,
          decoration: BoxDecoration(
              border: Border.all(color: color, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Align(
            alignment: Alignment.topLeft,
            child: FittedBox(
              child: Container(
                color: color,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${result.id}'),
                    Text(" ${result.score.toStringAsFixed(2)}"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic loadJSON(String jsonPath, BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString(jsonPath);
    final jsonResult = jsonDecode(data);
    return jsonResult;
  }
}