import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:testing_note/utils/util.dart';
import 'package:testing_note/views/main/model/wine.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();

  Rx<Wine> wine = new Wine().obs;

  final storage = GetStorage('user');

  var openDday;

  @override
  void onInit() {
    var arguments = Get.arguments;
    wine(arguments[0]);

    if(wine.value.openDt != '' && wine.value.openDt != null){
      final openDate = DateFormat('yyyy.MM.dd').parse(wine.value.openDt);
      final now = DateTime.now();

      openDday = now.difference(openDate).inDays;
    }

    super.onInit();
  }
}
