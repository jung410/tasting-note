import 'package:get/get.dart';
import 'package:testing_note/views/detail/controller/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailController());
  }
}