import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:testing_note/utils/constants.dart';
import 'package:testing_note/utils/util.dart';
import 'package:testing_note/views/detail/controller/detail_controller.dart';
import 'dart:io';

import 'package:testing_note/views/main/controller/main_controller.dart';
import 'package:testing_note/views/main/model/wine.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  final storage = GetStorage('user');

  TextEditingController nameController = TextEditingController();
  TextEditingController dBController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController caskController = TextEditingController();
  TextEditingController abvController = TextEditingController();
  TextEditingController buyPriceController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController buyDateController = TextEditingController();
  TextEditingController openDateController = TextEditingController();
  TextEditingController drinkDateController = TextEditingController();

  final scoreValueList = [
    0.5,
    1.0,
    1.5,
    2.0,
    2.5,
    3.0,
    3.5,
    4.0,
    4.5,
    5.0,
    5.5,
    6.0,
    6.5,
    7.0,
    7.5,
    8.0,
    8.5,
    9.0,
    9.5,
    10
  ];
  RxDouble selectedScoreValue = 10.0.obs;
  RxBool isHaving = false.obs;
  RxBool isEmptyBottle = false.obs;

  // File _image;
  PickedFile imageFile;
  File imageFileObj;
  RxBool isImageLoad = false.obs;
  RxBool isImageChange = false.obs;

  String imageFilePath = '';

  RxBool isRegistering = false.obs;

  Wine wine;
  CommUtils utils = new CommUtils();

  @override
  void onInit() {
    if(Get.arguments != null) {
      var arguments = Get.arguments;
      wine = arguments;

      nameController.text = wine.name;
      dBController.text = wine.db;
      typeController.text = wine.type;
      caskController.text = wine.cask;
      abvController.text = wine.abv.toString();
      buyPriceController.text = utils.numFormat(wine.buyPrice.toString());
      noteController.text = wine.note;
      totalController.text = wine.evaluation;
      buyDateController.text = wine.buyDt.toString();
      openDateController.text = wine.openDt.toString();
      drinkDateController.text = wine.drinkDt.toString();
      selectedScoreValue(wine.score);
      isHaving(wine.haveYn ? true : false);
      isEmptyBottle(wine.emptyYn ? true : false);
      if(wine.imageUrl != "") {
        isImageLoad(true);
        imageFilePath = wine.imageUrl;
      }
    }


    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    nameController.clear();
    dBController.clear();
    typeController.clear();
    caskController.clear();
    abvController.clear();
    buyPriceController.clear();
    noteController.clear();
    totalController.clear();
    buyDateController.clear();
    openDateController.clear();
    drinkDateController.clear();
    super.onClose();
  }

  Future<void> onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    // await _displayPickImageDialog(context,
    //     (double maxWidth, double maxHeight, int quality) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
        source: source,
        imageQuality: 20,
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        // imageQuality: quality,
      );
      // print('-------------- pickedFile -------------');
      // print(pickedFile);
      imageFile = pickedFile;
      if (pickedFile != null) {
        isImageLoad(true);
        imageFileObj = new File(pickedFile.path);
        var tempList = pickedFile.path.split('/');
        imageFilePath = tempList[tempList.length - 1];
      } else {
        isImageLoad(true);
      }
    } catch (e) {
      Get.back();
    }
  }

  Future<bool> uploadWine() async {
    isRegistering(true);
    String name = nameController.text;
    if(name == '' || name == null) {
      return false;
    }
    String db = dBController.text;
    String type = typeController.text;
    String cask = caskController.text;
    double abv =
        double.parse(abvController.text == '' ? '0.0' : abvController.text);
    String buyDate = buyDateController.text;
    int buyPrice = 0;
    if(buyPriceController.text == '') {
      buyPrice = 0;
    } else {
      var tempList = buyPriceController.text.split(',');
      String tempBuyPrice = '';
      for(int i = 0; i < tempList.length; i++){
        tempBuyPrice += tempList[i];
      }
      buyPrice = int.parse(tempBuyPrice);
    }
    // int buyPrice = int.parse(
    //     buyPriceController.text == '' ? '0' : buyPriceController.text.split(',').map((e) => null));
    String openDate = openDateController.text;
    String drinkDate = drinkDateController.text;
    double score = selectedScoreValue.value;
    bool have_yn = isHaving.value;
    bool empty_yn = isEmptyBottle.value;
    String note = noteController.text;
    String evaluation = totalController.text;
    DateTime regDate = DateTime.now();


    // await uploadFile(imageFile, imageFilePath);

    String url = '';
    if(imageFilePath != ''){
      String realImageFilePath = imageFilePath;
      final ref = FirebaseStorage.instance.ref().child('wine').child(realImageFilePath);
      await ref.putFile(imageFileObj);

      final downLoadRef = FirebaseStorage.instance.ref().child('wine').child('/$realImageFilePath');
      url = await downLoadRef.getDownloadURL();
    }
    String imageUrl = url;

    print('name :: $name \n');
    print('db :: $db \n');
    print('type :: $type \n');
    print('cask :: $cask \n');
    print('abv :: $abv \n');
    print('buyDate :: $buyDate \n');
    print('buyPrice :: $buyPrice \n');
    print('openDate :: $openDate \n');
    print('drinkDate :: $drinkDate \n');
    print('score :: $score \n');
    print('have_yn :: $have_yn \n');
    print('empty_yn :: $empty_yn \n');
    print('note :: $note \n');
    print('evaluation :: $evaluation \n');
    print('regDate :: $regDate \n');
    print('imageUrl :: $imageUrl \n');

    final f = FirebaseFirestore.instance;
    final userCollection = f.collection('user').doc(await storage.read('pin')).collection('wine');
    await userCollection.add({
      'abv': abv,
      'buy_dt': buyDate,
      'buy_price': buyPrice,
      'cask': cask,
      'db': db,
      'drink_dt': drinkDate,
      'empty_yn': empty_yn,
      'evaluation': evaluation,
      'have_yn': have_yn,
      'image_url': imageUrl,
      'name': name,
      'note': note,
      'open_dt': openDate,
      'score': score,
      'type': type,
      'reg_dt': regDate,
    }).then((value) {
      MainController.to.wineList(<Wine>[]);
      MainController.to.getInitData();
      isRegistering(false);
    }).catchError((error) => false);
    isRegistering(false);
    return true;
  }

  Future<bool> updateWine() async {
    isRegistering(true);
    String name = nameController.text;
    if(name == '' || name == null) {
      return false;
    }
    String db = dBController.text;
    String type = typeController.text;
    String cask = caskController.text;
    double abv =
    double.parse(abvController.text == '' ? '0.0' : abvController.text);
    String buyDate = buyDateController.text;
    int buyPrice = 0;
    if(buyPriceController.text == '') {
      buyPrice = 0;
    } else {
      var tempList = buyPriceController.text.split(',');
      String tempBuyPrice = '';
      for(int i = 0; i < tempList.length; i++){
        tempBuyPrice += tempList[i];
      }
      buyPrice = int.parse(tempBuyPrice);
    }
    // int buyPrice = int.parse(
    //     buyPriceController.text == '' ? '0' : buyPriceController.text);
    String openDate = openDateController.text;
    String drinkDate = drinkDateController.text;
    double score = selectedScoreValue.value;
    bool have_yn = isHaving.value;
    bool empty_yn = isEmptyBottle.value;
    String note = noteController.text;
    String evaluation = totalController.text;
    DateTime regDate = DateTime.now();


    // await uploadFile(imageFile, imageFilePath);

    String url = '';
    if(imageFilePath != wine.imageUrl) {
      if(imageFilePath != ''){
        String realImageFilePath = imageFilePath;
        final ref = FirebaseStorage.instance.ref().child('wine').child(realImageFilePath);
        await ref.putFile(imageFileObj);

        final downLoadRef = FirebaseStorage.instance.ref().child('wine').child('/$realImageFilePath');
        url = await downLoadRef.getDownloadURL();

        if (wine.imageUrl != '') {
          int startIndex = wine.imageUrl.indexOf('wine%2F');
          int endIndex = wine.imageUrl.indexOf('?alt=');
          String imageName = wine.imageUrl.substring(startIndex + 7, endIndex);
          final ref =
          FirebaseStorage.instance.ref().child('wine').child(imageName);
          await ref.delete();
        }
      } else {
        if (wine.imageUrl != '') {
          int startIndex = wine.imageUrl.indexOf('wine%2F');
          int endIndex = wine.imageUrl.indexOf('?alt=');
          String imageName = wine.imageUrl.substring(startIndex + 7, endIndex);
          final ref =
          FirebaseStorage.instance.ref().child('wine').child(imageName);
          await ref.delete();
        }
      }
    } else {
      url = wine.imageUrl;
    }
    String imageUrl = url;

    print('name :: $name \n');
    print('db :: $db \n');
    print('type :: $type \n');
    print('cask :: $cask \n');
    print('abv :: $abv \n');
    print('buyDate :: $buyDate \n');
    print('buyPrice :: $buyPrice \n');
    print('openDate :: $openDate \n');
    print('drinkDate :: $drinkDate \n');
    print('score :: $score \n');
    print('have_yn :: $have_yn \n');
    print('empty_yn :: $empty_yn \n');
    print('note :: $note \n');
    print('evaluation :: $evaluation \n');
    print('regDate :: $regDate \n');
    print('imageUrl :: $imageUrl \n');

    final f = FirebaseFirestore.instance;
    f.collection('user').doc(await storage.read('pin')).collection('wine').doc(wine.id).update({
      'abv': abv,
      'buy_dt': buyDate,
      'buy_price': buyPrice,
      'cask': cask,
      'db': db,
      'drink_dt': drinkDate,
      'empty_yn': empty_yn,
      'evaluation': evaluation,
      'have_yn': have_yn,
      'image_url': imageUrl,
      'name': name,
      'note': note,
      'open_dt': openDate,
      'score': score,
      'type': type,
    }).then((value) async {
      MainController.to.wineList(<Wine>[]);
      MainController.to.getInitData();

      final f = FirebaseFirestore.instance;
      var collection = f.collection('user');
      var querySnapshot = await collection.doc(await storage.read('pin')).collection('wine').doc(wine.id).get();
      DetailController.to.wine(Wine.fromJson(querySnapshot.data()));
      isRegistering(false);
    }).catchError((error) => false);;
    isRegistering(false);
    return true;
  }

  // Future<firebase_storage.UploadTask> uploadFile(PickedFile file, String imageFilePath) async {
  //   if (file == null) {
  //     return null;
  //   }
  //
  //   firebase_storage.UploadTask uploadTask;
  //
  //   // Create a Reference to the file
  //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('wine')
  //       .child('/$imageFilePath');
  //
  //   final metadata = firebase_storage.SettableMetadata(
  //       contentType: 'image/jpeg',
  //       customMetadata: {'picked-file-path': file.path});
  //
  //     uploadTask = ref.putFile(File(file.path), metadata);
  //
  //
  //   return Future.value(uploadTask);
  // }

}
