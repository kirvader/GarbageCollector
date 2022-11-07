import 'dart:core';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:garbage_collector/features/utils/camera_view_singleton.dart';
import 'package:garbage_collector/features/utils/recognition_result.dart';
import 'package:image/image.dart' as imageLib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Classifier {
  static const MAX_AMOUNT_OF_RESULTS = 10;
  static const clsConfTh = 0.5;
  /// Instance of Interpreter
  Interpreter? _interpreter;

  /// Labels file loaded as List
  List<String>? _labels;

  static const String MODEL_FILE_NAME = "detect.tflite";
  static const String LABEL_FILE_NAME = "labelmap.txt";

  /// Shapes of output tensors
  late List<List<int>> _outputShapes;

  /// Types of output tensors
  late List<TfLiteType> _outputTypes;
  late TensorBuffer output;

  Classifier(
  {Interpreter? interpreter,
    List<String>? labels}
  ) {
    loadModel(interpreter: interpreter);
    loadLabels(labels: labels);
  }

  /// Loads interpreter from asset
  void loadModel({Interpreter? interpreter}) async {
    try {
      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            MODEL_FILE_NAME,
            options: InterpreterOptions()..threads = 4,
          );

      var outputTensors = _interpreter!.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      output = TensorBuffer.createFixedSize(
          _interpreter!.getOutputTensor(0).shape,
          _interpreter!.getOutputTensor(0).type);
      outputTensors.forEach((tensor) {
        _outputShapes.add(tensor.shape);
        _outputTypes.add(tensor.type);
      });
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/$LABEL_FILE_NAME');
  }

  /// Loads labels from assets
  void loadLabels({List<String>? labels}) async {
    try {
      if (labels == null) {
        _labels = [];
        var whole_string = await loadAsset();
        for (var elem in whole_string.split('\n')) {
          _labels!.add(elem);
        }

      } else {
        _labels = labels;
      }
    } catch (e) {
      print("Error while loading labels: $e");
    }
  }

  /// Gets the interpreter instance
  Interpreter? get interpreter => _interpreter;

  /// Gets the loaded labels
  List<String>? get labels => _labels;

  /// Input size of image (height = width = 300)
  static const int INPUT_SIZE = 640;

  /// [ImageProcessor] used to pre-process the image
  late ImageProcessor imageProcessor;

  /// Padding the image to transform into square
  late int padSize;

  /// Pre-process the image
  TensorImage getProcessedImage(TensorImage inputImage) {
    padSize = max(inputImage.height, inputImage.width);

    // create ImageProcessor
    imageProcessor = ImageProcessorBuilder()
    // Padding the image
        .add(ResizeWithCropOrPadOp(padSize, padSize))
    // Resizing to input size
        .add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.BILINEAR))
        .build();

    var newInputImage = imageProcessor.process(inputImage);
    return newInputImage;
  }

  List<Recognition> getResultsFromYOLOOutput(List<double> results, int clsNum) {
    List<Recognition> result = [];
    for (var i = 0; i < results.length; i += (5 + clsNum)) {
      var confs = results.sublist(i + 5, i + 5 + clsNum - 1);
      double maxClsConf = confs.reduce(max);
      if (maxClsConf * results[i + 4] < clsConfTh) continue;
      int cls = confs.indexOf(maxClsConf) % clsNum;
      double centerY = results[i];
      double centerX = 1 - results[i + 1];
      double height = results[i + 2];
      double width = results[i + 3];
      double conf = results[i + 4] * maxClsConf;
      double left = (centerX - 0.5 * width);
      double top = (centerY - 0.5 * height);
      result.add(Recognition(cls, "cls", conf, Rect.fromLTWH(left, top, width, height)));
    }
    return result;
  }

  /// Runs object detection on the input image
  Map<String, dynamic> predict(imageLib.Image image) {
    var predictStartTime = DateTime.now().millisecondsSinceEpoch;

    if (_interpreter == null) {
      print("Interpreter not initialized");
      return {};
    }

    var preProcessStart = DateTime.now().millisecondsSinceEpoch;


    var preProcessElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preProcessStart;

    // TensorBuffers for output tensors
    // Inputs object for runForMultipleInputs
    // Use [TensorImage.buffer] or [TensorBuffer.buffer] to pass by reference
    TensorImage inputImage = TensorImage.fromImage(image);
    inputImage = getProcessedImage(inputImage);
    List<double> l = inputImage.tensorBuffer
        .getDoubleList()
        .map((e) => e / 255.0)
        .toList();
    TensorBuffer normalizedTensorBuffer = TensorBuffer.createDynamic(TfLiteType.float32);
    normalizedTensorBuffer.loadList(l, shape: [INPUT_SIZE, INPUT_SIZE, 3]);
    _interpreter!.run(normalizedTensorBuffer.buffer, output.buffer);
    List<double> results = output.getDoubleList();

    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    var inferenceTimeElapsed =
        DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    return { "recognitions": getResultsFromYOLOOutput(results, 25)};
  }

}