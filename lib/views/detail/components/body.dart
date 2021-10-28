import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:testing_note/utils/constants.dart';
import 'package:testing_note/utils/util.dart';
import 'package:testing_note/views/detail/controller/detail_controller.dart';
import 'package:testing_note/views/main/model/wine.dart';

class Body extends GetView<DetailController> {
  CommUtils utils = new CommUtils();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Stack(
            children: [
              Container(
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                  image: controller.wine.value.imageUrl != ''
                      ? DecorationImage(
                          image: NetworkImage(
                            controller.wine.value.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage(
                            'assets/noimg.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              // CachedNetworkImage(
              //   imageUrl: controller.wine.value.imageUrl,
              //   imageBuilder: (context, imageProvider) => Container(
              //     height: Get.height * 0.5,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: imageProvider,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              //   errorWidget: (context, url, error) => Container(
              //     height: Get.height * 0.5,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage(
              //           'assets/noimg.png',
              //         ),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //   height: Get.height * 0.5,
              //   decoration: BoxDecoration(
              //     image: buildDecorationImage(),
              //   ),
              // ),

              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.wine.value.imageUrl != '') {
                            Get.toNamed('/photo_view',
                                arguments: controller.wine.value.imageUrl);
                          }
                        },
                        child: Container(
                          height: Get.height * 0.4,
                          color: Colors.white.withOpacity(0.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        width: Get.width * 0.87,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildTextContainerForFirstLine(
                              'NAME : ' +
                                  utils.stringNullCheck(
                                      controller.wine.value.name),
                              controller.wine.value.score,
                            ),
                            _buildTextContainer(
                              'D/B : ' +
                                  utils.stringNullCheck(
                                      controller.wine.value.db),
                            ),
                            _buildTextContainer(
                              'TYPE : ' +
                                  utils.stringNullCheck(
                                      controller.wine.value.type),
                            ),
                            _buildTextContainer(
                              'CASK : ' +
                                  utils.stringNullCheck(
                                      controller.wine.value.cask),
                            ),
                            _buildTextContainer(
                              'ABV : ' +
                                  controller.wine.value.abv.toString() +
                                  '%',
                            ),
                            _buildTextContainer(
                              '시음일 : ' +
                                  utils.stringNullCheck(
                                      controller.wine.value.drinkDt),
                            ),
                            _buildTextContainerWithOpenDday(
                              '구매일 : ' +
                                  utils.stringNullCheck(
                                      controller.wine.value.buyDt),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withOpacity(0.2),
                      //         offset: Offset(1.0, 1.0),
                      //         blurRadius: 5.0,
                      //       ),
                      //     ],
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(8.0),
                      //     ),
                      //   ),
                      //   width: Get.width * 0.87,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       SizedBox(
                      //         height: 10.0,
                      //       ),
                      //       _buildTextContainer(
                      //         '시음일 : ' +
                      //             utils.stringNullCheck(controller.wine.value.drinkDt),
                      //       ),
                      //       _buildTextContainerWithOpenDday(
                      //         '구매일 : ' +
                      //             utils.stringNullCheck(controller.wine.value.buyDt),
                      //       ),
                      //       SizedBox(
                      //         height: 10.0,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15.0,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        width: Get.width * 0.87,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            _buildTextContainerPrice(
                              '￦ ' +
                                  utils.stringNullCheck(
                                    utils
                                        .numFormat(
                                          controller.wine.value.buyPrice
                                              .toString(),
                                        )
                                        .toString(),
                                  ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        width: Get.width * 0.87,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildTextContainerLong(
                                controller.wine.value.note, '노트'),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildTextContainerLong(
                                controller.wine.value.evaluation, '총평'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withOpacity(0.2),
                      //         offset: Offset(1.0, 1.0),
                      //         blurRadius: 5.0,
                      //       ),
                      //     ],
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(8.0),
                      //     ),
                      //   ),
                      //   width: Get.width * 0.87,
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 20.0,
                      //       ),
                      //       _buildTextContainerLong(
                      //           controller.wine.value.evaluation, '총평'),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _alertUpdate(controller.wine.value).show();
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                right: 10,
                top: 15,
              ),
            ],
          ),
        ));
  }

  DecorationImage buildDecorationImage() {
    try {
      return DecorationImage(
        image: NetworkImage(
          controller.wine.value.imageUrl,
        ),
        fit: BoxFit.cover,
      );
    } catch (e) {
      return DecorationImage(
        image: AssetImage(
          'assets/noimg.png',
        ),
        fit: BoxFit.cover,
      );
    }
  }

  Widget _buildTextContainer(String text) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
                left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextContainerLong(String text, String label) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
                left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.transparent)),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.transparent)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.transparent)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.transparent)),
              ),
              child: Text(
                text,
                // maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextContainerPrice(String text) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextContainerForFirstLine(String text, double score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
                left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Container(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                " ${score.toString()}/10",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextContainerWithOpenDday(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
                left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 5.0),
          child: Text(
            controller.wine.value.emptyYn == true
                ? 'EMPTY'
                : controller.wine.value.openDt != null && controller.wine.value.openDt != ""
                    ? 'OPEN D+' + DateTime.now().difference(DateFormat('yyyy.MM.dd').parse(controller.wine.value.openDt)).inDays.toString()
                    : 'NEW',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Alert _alertUpdate(Wine wine) {
    return Alert(
      context: Get.context,
      padding: EdgeInsets.all(0),
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
      // title: "삭제 혹은 수정을 선택하세요.",
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(30),
          color: kPrimaryColor,
          child: Text(
            "수정",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {
            Get.back();
            Get.toNamed('/register', arguments: wine);
          },
        ),
        DialogButton(
          radius: BorderRadius.circular(30),
          color: Colors.black.withOpacity(0.7),
          child: Text(
            "삭제",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {
            _alertDelete(controller.wine.value.id, controller.wine.value.imageUrl??"").show();
          },
        ),
      ],
    );
  }

  Alert _alertDelete(String id, String imageUrl) {
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
      title: '정말 삭제하시겠습니까?',
      buttons: [
        DialogButton(
            radius: BorderRadius.circular(30),
            color: Colors.red,
            child: Text(
              "삭제",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () async {
              if (imageUrl != '') {
                int startIndex = imageUrl.indexOf('wine%2F');
                int endIndex = imageUrl.indexOf('?alt=');
                String imageName = imageUrl.substring(startIndex + 7, endIndex);
                final ref = FirebaseStorage.instance
                    .ref()
                    .child('wine')
                    .child(imageName);
                await ref.delete();
              }
              CollectionReference cref = FirebaseFirestore.instance
                  .collection('user')
                  .doc(controller.storage.read('pin'))
                  .collection('wine');
              cref.doc(id).delete().then((value) async {
                await Alert(
                  context: Get.context,
                  title: '삭제되었습니다.',
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
                      color: Colors.red,
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "확인",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ).show();
                Get.offAllNamed('/main');
              }).catchError((error) => print(error));
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
}


