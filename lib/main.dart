import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testing_note/route/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await GetStorage.init('user');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      // allowFontScaling: false,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false, // debug 띠 삭제
        enableLog: true, // getX log 허용
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'NanumBarunpenB',
          // primarySwatch: Colors.indigo,
        ),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        // home: MyHomePage(title: '플러터 레퍼런스'),
      ),
    );
  }
}
