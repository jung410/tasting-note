import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:testing_note/utils/constants.dart';
import 'package:testing_note/utils/util.dart';
import 'package:testing_note/views/detail/controller/detail_controller.dart';
import 'package:testing_note/views/main/model/wine.dart';
import 'package:testing_note/views/register/controller/register_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class Body extends GetView<RegisterController> {
  CommUtils utils = new CommUtils();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('노트 작성'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                // controller.uploadWine();
                _alertSaveConfirm().show();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 20.0,
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kPrimaryColor,
                    ),
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 5.0,
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Text(
                      '저장',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: Get.width * 0.87,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildNameInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildDBTypeInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildCASKABVInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildBuyInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildOpenInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildScoreInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildNoteInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildTotalInput(),
                    SizedBox(
                      height: 20.0,
                    ),
                    controller.isImageLoad.value
                        ? Column(
                            children: [
                              Container(
                                width: Get.width * 0.87,
                                height: Get.width * 0.87 * 1.414,
                                child: (controller.imageFilePath != '') &
                                        (controller.imageFileObj == null)
                                    ? Image.network(controller.imageFilePath)
                                    : Image.file(controller.imageFileObj),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _imagePickerButton('이미지변경', kPrimaryColor),
                                  _imagePickerButton('이미지삭제', Colors.red),
                                ],
                              )
                            ],
                          )
                        : _imagePickerButton('이미지첨부', kPrimaryColor),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _imagePickerButton(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: Colors.white,
          backgroundColor: color,
        ),
        onPressed: () async {
          if (title == '이미지삭제') {
            controller.isImageLoad(false);
            controller.imageFileObj = null;
            controller.imageFilePath = "";
          } else if (title == '이미지변경') {
            controller.isImageLoad(false);
            await controller.onImageButtonPressed(
              ImageSource.gallery,
              context: Get.context,
            );
            if (controller.imageFileObj != null) {
              controller.imageFilePath = "";
            }
          } else {
            controller.isImageLoad(false);
            await controller.onImageButtonPressed(
              ImageSource.gallery,
              context: Get.context,
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDBTypeInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Distillesrs/\nBottler',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: controller.dBController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\nTYPE',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: controller.typeController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCASKABVInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CASK',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: controller.caskController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABV',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: controller.abvController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Text(
                      "%",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    suffixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBuyInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '구매일',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  readOnly: true,
                  controller: controller.buyDateController,
                  onTap: () {
                    DatePicker.showDatePicker(Get.context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 1, 1),
                        maxTime: DateTime(2030, 12, 31), onChanged: (date) {
                      String dateString = date.year.toString() +
                          '.' +
                          date.month.toString() +
                          '.' +
                          date.day.toString();
                      controller.buyDateController.text = dateString;
                    }, onCancel: () {
                      controller.buyDateController.clear();
                    }, onConfirm: (date) {
                      String dateString = date.year.toString() +
                          '.' +
                          date.month.toString() +
                          '.' +
                          date.day.toString();
                      controller.buyDateController.text = dateString;
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '구매가',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: controller.buyPriceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsFormatter(),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: Text(
                      "원",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    suffixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOpenInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '개봉일',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  readOnly: true,
                  controller: controller.openDateController,
                  onTap: () {
                    DatePicker.showDatePicker(Get.context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 1, 1),
                        maxTime: DateTime(2030, 12, 31), onChanged: (date) {
                      String dateString = date.year.toString() +
                          '.' +
                          date.month.toString() +
                          '.' +
                          date.day.toString();
                      controller.openDateController.text = dateString;
                    }, onCancel: () {
                      controller.openDateController.clear();
                    }, onConfirm: (date) {
                      String dateString = date.year.toString() +
                          '.' +
                          date.month.toString() +
                          '.' +
                          date.day.toString();
                      controller.openDateController.text = dateString;
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '시음일',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  readOnly: true,
                  controller: controller.drinkDateController,
                  onTap: () {
                    DatePicker.showDatePicker(Get.context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 1, 1),
                        maxTime: DateTime(2030, 12, 31), onChanged: (date) {
                      String dateString = date.year.toString() +
                          '.' +
                          date.month.toString() +
                          '.' +
                          date.day.toString();
                      controller.drinkDateController.text = dateString;
                    }, onCancel: () {
                      controller.drinkDateController.clear();
                    }, onConfirm: (date) {
                      String dateString = date.year.toString() +
                          '.' +
                          date.month.toString() +
                          '.' +
                          date.day.toString();
                      controller.drinkDateController.text = dateString;
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildScoreInput() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '총점',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: controller.selectedScoreValue.value,
                      items: controller.scoreValueList.map(
                        (value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value.toString()),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        controller.selectedScoreValue(value);
                      },
                    ),
                    Text(
                      '/10',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.87 * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        '보유여부',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Checkbox(
                      activeColor: kPrimaryColor,
                      value: controller.isHaving.value,
                      onChanged: (value) {
                        controller.isHaving(value);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text(
                        '빈 병',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Checkbox(
                      activeColor: kPrimaryColor,
                      value: controller.isEmptyBottle.value,
                      onChanged: (value) {
                        controller.isEmptyBottle(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildNoteInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '노트',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: controller.noteController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: '노트를 입력하세요.',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTotalInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '총평',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: controller.totalController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: '전체 총평을 입력하세요.',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildNameInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NAME',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: controller.nameController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 10.0),
            ),
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Alert _alertSaveConfirm() {
    return Alert(
      context: Get.context,
      style: AlertStyle(
        isCloseButton: false,
        descStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        descTextAlign: TextAlign.center,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleTextAlign: TextAlign.center,
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        alertAlignment: Alignment.center,
      ),
      title: '저장하시겠습니까?',
      buttons: [
        DialogButton(
            radius: BorderRadius.circular(30),
            color: kPrimaryColor,
            child: Text(
              "저장",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () async {
              Alert(
                context: Get.context,
                onWillPopActive: true,
                title: '저장중입니다...',
                style: AlertStyle(
                  isCloseButton: false,
                  descStyle: TextStyle(fontSize: 16, color: Colors.white),
                  descTextAlign: TextAlign.center,
                  alertBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  titleTextAlign: TextAlign.center,
                  titleStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  alertAlignment: Alignment.center,
                  isOverlayTapDismiss: false,
                ),
                buttons: [
                  DialogButton(
                    height: 0,
                    width: 0,
                    radius: BorderRadius.circular(30),
                    color: kPrimaryColor.withOpacity(0.0),
                    onPressed: () {},
                    child: Text(
                      "확인",
                      style: TextStyle(color: Colors.white, fontSize: 0),
                    ),
                  )
                ],
              ).show();
              bool isSuccess = false;
              String title;
              if (controller.wine != null) {
                isSuccess = await controller.updateWine();
                title = '수정되었습니다.';
              } else {
                isSuccess = await controller.uploadWine();
                title = '저장되었습니다.';
              }
              if (!isSuccess) {
                Get.back();
                _alertSaveNameConfirm().show();
              } else {
                await Alert(
                  context: Get.context,
                  title: title,
                  style: AlertStyle(
                    isCloseButton: false,
                    descStyle: TextStyle(fontSize: 16, color: Colors.white),
                    descTextAlign: TextAlign.center,
                    alertBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    titleTextAlign: TextAlign.center,
                    titleStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    alertAlignment: Alignment.center,
                  ),
                  buttons: [
                    DialogButton(
                      radius: BorderRadius.circular(30),
                      color: kPrimaryColor,
                      onPressed: () async {
                        Get.back();
                        Get.back();
                        Get.back();
                      },
                      child: Text(
                        "확인",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ).show();
                Get.back();
              }
            }),
        DialogButton(
          radius: BorderRadius.circular(30),
          color: Colors.grey.withOpacity(0.7),
          child: Text(
            "취소",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Alert _alertSaveNameConfirm() {
    return Alert(
      context: Get.context,
      style: AlertStyle(
        isCloseButton: false,
        descStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        descTextAlign: TextAlign.center,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleTextAlign: TextAlign.center,
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        alertAlignment: Alignment.center,
      ),
      title: '최소한 이름은 입력되어야 합니다.',
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(30),
          color: kPrimaryColor,
          child: Text(
            "확인",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {
            Get.back();
            Get.back();
          },
        ),
      ],
    );
  }
}
