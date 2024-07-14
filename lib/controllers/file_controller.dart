import 'package:get/get.dart';

class FileController extends GetxController {
  static FileController get to => Get.find();

  var filePath = "".obs;

  void setFilePath(String newFilePath) {
    filePath.value = newFilePath;
  }
}
