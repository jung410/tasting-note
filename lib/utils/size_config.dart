import 'package:get/get.dart';

// Get.width : display의 width
// Get.context.devicePixelRatio : 화면 비율
// 기기의 해상도 가로 길이 : Get.width * Get.context.devicePixelRatio
// 기기의 해상도 세로 길이 : Get.height * Get.context.devicePixelRatio
// Get.width, Get.height, Get.context.devicePixelRatio의 상수들을 조합하여 사이즈 비율 산정 필요

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  // 디자인 화면 기준 높이 640
  return (inputHeight / 640) * Get.height;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  // 디자인 화면 기준 가로 360
  return (inputWidth / 360) * Get.width;
}

double getProportionateFont(double inputsize) {
  return (inputsize / 100) * Get.height;
}
