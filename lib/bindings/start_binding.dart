import 'package:get/get.dart';
import 'package:testing_note/views/start/controller/start_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartController());
  }
}
