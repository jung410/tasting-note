import 'package:get/get.dart';
import 'package:testing_note/bindings/detail_binding.dart';
import 'package:testing_note/bindings/main_binding.dart';
import 'package:testing_note/bindings/register_binding.dart';
import 'package:testing_note/bindings/start_binding.dart';
import 'package:testing_note/views/detail/detail_screen.dart';
import 'package:testing_note/views/detail/views/photo_view_screen.dart';
import 'package:testing_note/views/main/main_screen.dart';
import 'package:testing_note/views/register/register.dart';
import 'package:testing_note/views/start/start_screen.dart';

class AppPages {
  static const INITIAL = '/start';
  static final routes = [
    GetPage(
      name: StartScreen.routeName,
      page: () => StartScreen(),
      binding: StartBinding(),
    ),
    GetPage(
      name: MainScreen.routeName,
      page: () => MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RegisterScreen.routeName,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: DetailScreen.routeName,
      page: () => DetailScreen(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: PhotoViewScreen.routeName,
      page: () => PhotoViewScreen(),
    ),
  ];
}
