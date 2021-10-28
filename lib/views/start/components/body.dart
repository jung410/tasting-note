import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testing_note/utils/constants.dart';
import 'package:testing_note/views/start/controller/start_controller.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Body extends GetView<StartController> {
  final storage = GetStorage('user');

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: Get.width * 0.87,
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 100,
                  // ),
                  // Text(
                  //   '인증번호',
                  //   style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   '발급받은 인증번호를 입력해주세요.',
                  //   style: TextStyle(fontSize: 22),
                  // ),
                  SizedBox(
                    height: 80,
                  ),
                  PinPut(
                    fieldsAlignment: MainAxisAlignment.spaceEvenly,
                    eachFieldWidth: 60.0,
                    eachFieldHeight: 60.0,
                    withCursor: true,
                    fieldsCount: 4,
                    focusNode: controller.pinFocus,
                    controller: controller.pinController,
                    onSubmit: (String pin) async {
                      final f = FirebaseFirestore.instance;
                      // QuerySnapshot querySnapshot =
                      //     await f.collection('user').get();

                      var collection = f.collection('user');
                      var docSnapshot = await collection.doc(pin).get();
                      if (docSnapshot.exists) {
                        storage.write('pin', pin);
                        Get.offNamed('/main');
                      } else {
                        Get.snackbar('존재하지 않는 인증번호 입니다.', '다시 입력해주세요.');
                        controller.pinController.clear();
                      }

                      // if(querySnapshot.docs.length == 0){
                      //   Get.snackbar('존재하지 않는 인증번호 입니다.', '다시 입력해주세요.');
                      //   controller.pinController.clear();
                      // } else {
                      //   Get.offNamed('/main');
                      // }
                      // print(pin);
                    },
                    submittedFieldDecoration: _pinPutDecoration,
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration,
                    pinAnimationType: PinAnimationType.scale,
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Container(
                    width: Get.width * 0.8,
                    child: Image.asset(
                      "assets/splash.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
