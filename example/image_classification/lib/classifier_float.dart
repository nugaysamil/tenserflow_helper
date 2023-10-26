import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

import '../../text_classification_task/lib/classifier.dart';

class ClassifierFloat extends Classifier {
  ClassifierFloat({int? numThreads}) : super();

  @override
  String get modelName => 'mobilenet_v1_1.0_224.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
  
  @override
  List<Category> classify(String text) {
    // TODO: implement classify
    throw UnimplementedError();
  }
}
