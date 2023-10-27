import 'package:camera/camera.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter_plus/tflite_flutter_plus.dart';
import 'package:tflite_flutter_helper_plus/src/image/base_image_container.dart';
import 'package:tflite_flutter_helper_plus/src/image/image_conversions.dart';
import 'package:tflite_flutter_helper_plus/src/tensorbuffer/tensorbuffer.dart';
import 'package:tflite_flutter_helper_plus/src/image/color_space_type.dart';

class ImageContainer extends BaseImageContainer {
  Image? _image;

  ImageContainer._(Image image) {
    _image = image;
  }

  static ImageContainer create(Image image) {
    return ImageContainer._(image);
  }

  @override
  BaseImageContainer clone() {
    return create(_image!.clone());
  }

  @override
  ColorSpaceType get colorSpaceType {
    int? len = _image?.data.length;
    bool isGrayscale = true;
    for (int i = (len! / 4).floor(); i < _image!.data.length; i++) {
      if (_image!.data[i] != 0) {
        isGrayscale = false;
        break;
      }
    }
    if (isGrayscale) {
      return ColorSpaceType.grayscale;
    } else {
      return ColorSpaceType.rgb;
    }
  }

   /* ColorSpaceType get colorSpaceType {
    int? len = _image!.data.length;
    bool isGrayscale = true;
    for (int i = (len / 4).floor(); i < _image!.data.length; i++) {
      if (_image!.data[i] != 0) {
        isGrayscale = false;
        break;
      }
    }
    if (isGrayscale) {
      return ColorSpaceType.grayscale;
    } else {
      return ColorSpaceType.rgb;
    }
  } */

  @override
  TensorBuffer getTensorBuffer(TfLiteType dataType) {
    TensorBuffer buffer = TensorBuffer.createDynamic(dataType);
    ImageConversions.convertImageToTensorBuffer(image, buffer);
    return buffer;
  }

  @override
  int get height => _image!.height!;

  @override
  Image get image => _image!;

  @override
  CameraImage get mediaImage => throw UnsupportedError(
      'Converting from Image to CameraImage is unsupported');

  @override
  int get width => _image!.width!;
}
