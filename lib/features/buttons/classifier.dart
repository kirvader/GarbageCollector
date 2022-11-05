import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  /// Instance of Interpreter
  late Interpreter _interpreter;

  /// Labels file loaded as List
  late List<String> _labels;

  static const String MODEL_FILE_NAME = "detect.tflite";
  static const String LABEL_FILE_NAME = "labelmap.txt";

  /// Shapes of output tensors
  late List<List<int>> _outputShapes;

  /// Types of output tensors
  late List<TfLiteType> _outputTypes;

  Classifier(
    Interpreter interpreter,
    List<String> labels,
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

      var outputTensors = _interpreter.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      outputTensors.forEach((tensor) {
        _outputShapes.add(tensor.shape);
        _outputTypes.add(tensor.type);
      });
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  /// Loads labels from assets
  void loadLabels({List<String>? labels}) async {
    try {
      _labels =
          labels ?? await FileUtil.loadLabels("assets/" + LABEL_FILE_NAME);
    } catch (e) {
      print("Error while loading labels: $e");
    }
  }

  /// Gets the interpreter instance
  Interpreter get interpreter => _interpreter;

  /// Gets the loaded labels
  List<String> get labels => _labels;
}