import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class StartController extends GetxController with SingleGetTickerProviderMixin {
  static StartController get to => Get.find();

  TextEditingController pinController = new TextEditingController();
  FocusNode pinFocus = FocusNode();

  @override
  void onInit() {
    Permission.storage.request();
    super.onInit();
  }

}
