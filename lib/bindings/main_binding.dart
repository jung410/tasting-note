import 'package:get/get.dart';
import 'package:testing_note/views/main/controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
