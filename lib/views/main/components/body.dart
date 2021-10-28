import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:testing_note/utils/constants.dart';
import 'package:testing_note/views/main/controller/main_controller.dart';
import 'package:testing_note/views/main/model/wine.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class Body extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: AppBar(
              leadingWidth: 90,
              leading: Padding(
                padding: const EdgeInsets.only(left: 0, top: 0),
                child: Container(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      buttonTheme: ButtonTheme.of(context).copyWith(
                        alignedDropdown:
                            true, //If false (the default), then the dropdown's menu will be wider than its button.
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        style: TextStyle(
                          fontFamily: 'NanumBarunpenB',
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                        elevation: 0,
                        value: controller.dropBoxValue,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "ALL",
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "OPEN",
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "NEW",
                            ),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "EMPTY",
                            ),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "평점",
                            ),
                            value: 5,
                          ),
                        ],
                        onChanged: (int value) {
                          controller.dropBoxValue = value;
                          if (value != 5) {
                            controller.isScoreClick(false);
                            controller.dropBoxChange();
                          } else if (value == 5) {
                            controller.isScoreClick(true);
                          }
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                SizedBox(
                  width: 90,
                ),
                controller.isScoreClick.value
                    ? Container(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            buttonTheme: ButtonTheme.of(context).copyWith(
                              alignedDropdown:
                                  true, //If false (the default), then the dropdown's menu will be wider than its button.
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              style: TextStyle(
                                fontFamily: 'NanumBarunpenB',
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                              elevation: 0,
                              value: controller.scoreDropBoxValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "10",
                                  ),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "9",
                                  ),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "8",
                                  ),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "7",
                                  ),
                                  value: 4,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "6",
                                  ),
                                  value: 5,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "5",
                                  ),
                                  value: 6,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "4",
                                  ),
                                  value: 7,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "3",
                                  ),
                                  value: 8,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "2",
                                  ),
                                  value: 9,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "1",
                                  ),
                                  value: 10,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "0",
                                  ),
                                  value: 11,
                                ),
                              ],
                              onChanged: (int value) {
                                controller.score = 11 - value;
                                controller.scoreDropBoxValue = value;
                                controller.scoreDropBoxChange();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.wineList.length == 0
                    ? Center(
                        child: Text('작성 된 노트가 없습니다.'),
                      )
                    : Column(
                        children: [
                          Container(
                            child: new TabBar(
                              onTap: (value) {
                                controller.tabValue(value);
                              },
                              indicatorColor: Colors.black,
                              unselectedLabelColor: const Color(0xffa7a7a8),
                              unselectedLabelStyle:
                                  TextStyle(fontWeight: FontWeight.w100),
                              labelColor: Colors.black,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              controller: controller.tabController,
                              tabs: [
                                Tab(
                                  child: Text(
                                    '전체',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: -0.48,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    '보유',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: -0.48,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: Get.width * 0.96,
                              child: TabBarView(
                                controller: controller.tabController,
                                children: <Widget>[
                                  RefreshIndicator(
                                    onRefresh: controller.getInitData,
                                    child: ListView.builder(
                                      // inner ListView
                                      shrinkWrap: true, // 1st add
                                      physics: const BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      itemCount: controller.wineList.length,
                                      itemBuilder: (_, index) => _buildList(
                                        controller.wineList[index].imageUrl,
                                        controller.wineList[index].name,
                                        controller.wineList[index].score,
                                        controller.wineList[index].db,
                                        controller.wineList[index].cask,
                                        controller.wineList[index].drinkDt,
                                        controller.wineList[index].openDt,
                                        controller.wineList[index].id,
                                        controller.wineList[index].emptyYn,
                                        controller.wineList[index],
                                      ),
                                    ),
                                  ),
                                  RefreshIndicator(
                                    onRefresh: controller.getInitData,
                                    child: controller.emptyWineList.length != 0
                                        ? ListView.builder(
                                            // inner ListView
                                            shrinkWrap: true, // 1st add
                                            physics: const BouncingScrollPhysics(
                                                parent:
                                                    AlwaysScrollableScrollPhysics()),
                                            itemCount:
                                                controller.emptyWineList.length,
                                            itemBuilder: (_, index) =>
                                                _buildList(
                                              controller.emptyWineList[index]
                                                  .imageUrl,
                                              controller
                                                  .emptyWineList[index].name,
                                              controller
                                                  .emptyWineList[index].score,
                                              controller
                                                  .emptyWineList[index].db,
                                              controller
                                                  .emptyWineList[index].cask,
                                              controller
                                                  .emptyWineList[index].drinkDt,
                                              controller
                                                  .emptyWineList[index].openDt,
                                              controller
                                                  .emptyWineList[index].id,
                                              controller
                                                  .emptyWineList[index].emptyYn,
                                              controller.emptyWineList[index],
                                            ),
                                          )
                                        : Center(child: Text('보유중인 와인이 없습니다.')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
          floatingActionButton: FabCircularMenu(
            key: controller.fabKey,
            ringColor: Colors.orange,
            ringDiameter: Get.width * 0.40,
            ringWidth: Get.width * 0.5 * 0.20,
            fabSize: 45.0,
            fabColor: Colors.orange,
            fabOpenIcon: Icon(Icons.add),
            children: <Widget>[
              IconButton(
                splashColor: Colors.black.withOpacity(0),
                highlightColor: Colors.black.withOpacity(0),
                icon: Icon(
                  Icons.backup,
                  size: 30.0,
                ),
                onPressed: () async {
                  if (controller.tabValue.value == 0 &&
                      controller.dropBoxValue == 1) {
                    final now = DateTime.now();
                    var excel = Excel.createExcel();
                    Sheet sheetObject = excel['Sheet1'];

                    CellStyle cellStyle =
                        CellStyle(backgroundColorHex: "#1AFF1A");
                    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
                    var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
                    var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
                    var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
                    var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
                    var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
                    var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
                    var cell8 = sheetObject.cell(CellIndex.indexByString("H1"));
                    var cell9 = sheetObject.cell(CellIndex.indexByString("I1"));
                    var cell10 =
                        sheetObject.cell(CellIndex.indexByString("J1"));
                    var cell11 =
                        sheetObject.cell(CellIndex.indexByString("K1"));
                    var cell12 =
                        sheetObject.cell(CellIndex.indexByString("L1"));
                    var cell13 =
                        sheetObject.cell(CellIndex.indexByString("M1"));
                    var cell14 =
                        sheetObject.cell(CellIndex.indexByString("N1"));
                    cell.value = 'NAME';
                    cell2.value = 'Distillers/Bottler';
                    cell3.value = 'TYPE';
                    cell4.value = 'CASK';
                    cell5.value = 'ABV';
                    cell6.value = '구매일';
                    cell7.value = '구매가';
                    cell8.value = '개봉일';
                    cell9.value = '시음일';
                    cell10.value = '총점';
                    cell11.value = '보유여부';
                    cell12.value = '빈병여부';
                    cell13.value = '노트';
                    cell14.value = '총평';
                    cell.cellStyle = cellStyle;
                    cell2.cellStyle = cellStyle;
                    cell3.cellStyle = cellStyle;
                    cell4.cellStyle = cellStyle;
                    cell5.cellStyle = cellStyle;
                    cell6.cellStyle = cellStyle;
                    cell7.cellStyle = cellStyle;
                    cell8.cellStyle = cellStyle;
                    cell9.cellStyle = cellStyle;
                    cell10.cellStyle = cellStyle;
                    cell11.cellStyle = cellStyle;
                    cell12.cellStyle = cellStyle;
                    cell13.cellStyle = cellStyle;
                    cell14.cellStyle = cellStyle;
                    List<Wine> wineList = controller.wineList;
                    for (int i = 0; i < wineList.length; i++) {
                      List<String> tempList = [];
                      tempList.add(wineList[i].name.toString());
                      tempList.add(wineList[i].db.toString());
                      tempList.add(wineList[i].type.toString());
                      tempList.add(wineList[i].cask.toString());
                      tempList.add(wineList[i].abv.toString());
                      tempList.add(wineList[i].buyDt.toString());
                      tempList.add(wineList[i].buyPrice.toString());
                      tempList.add(wineList[i].openDt.toString());
                      tempList.add(wineList[i].drinkDt.toString());
                      tempList.add(wineList[i].score.toString());
                      tempList.add(wineList[i].haveYn ? '보유' : '미보유');
                      tempList.add(wineList[i].emptyYn ? '빈병' : '남음');
                      tempList.add(wineList[i].note.toString());
                      tempList.add(wineList[i].evaluation.toString());
                      if (i == 0) {
                        sheetObject.insertRowIterables(tempList, 1);
                      } else {
                        sheetObject.appendRow(tempList);
                      }
                    }
                    String fileName = 'tasting_note_' +
                        now.year.toString() +
                        now.month.toString() +
                        now.day.toString() +
                        now.hour.toString() +
                        now.minute.toString() +
                        now.second.toString() +
                        ".xlsx";
                    excel.encode().then((onValue) {
                      File(join(
                          controller.downloadDirectory.path + "/" + fileName))
                        ..createSync(recursive: true)
                        ..writeAsBytesSync(onValue);
                    });

                    print('저장성공');
                    _alertCompleteBackup(fileName).show();
                  } else {
                    _alertCancelBackup().show();
                  }
                },
              ),
              IconButton(
                splashColor: Colors.black.withOpacity(0),
                highlightColor: Colors.black.withOpacity(0),
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                onPressed: () {
                  Get.toNamed('/register');
                  if (controller.fabKey.currentState.isOpen) {
                    controller.fabKey.currentState.close();
                  }
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildList(
      String imageUrl,
      String title,
      double score,
      String db,
      String cask,
      String drinkYmd,
      String openDt,
      String id,
      bool emptyYn,
      Wine wine) {
    var openDday;

    if (openDt != '' && openDt != null) {
      final openDate = DateFormat('yyyy.MM.dd').parse(wine.openDt);
      final now = DateTime.now();

      openDday = now.difference(openDate).inDays;
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed('/detail', arguments: [wine]);
      },
      child: Container(
        padding: EdgeInsets.only(top: 6, bottom: 6),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 0, color: Colors.transparent),
            bottom: BorderSide(width: 0.5, color: kColor190),
          ),
        ),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: ListTile(
                  leading: Container(
                    width: 70,
                    height: 200,
                    child: imageUrl != ''
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image.asset(
                                'assets/noimg.png',
                                fit: BoxFit.fill,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/noimg.png',
                            fit: BoxFit.fill,
                          ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(" ${score.toString()}/10"),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "D/B : ",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Expanded(
                            child: Text(
                              db,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "CASK : ",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Expanded(
                            child: Text(
                              cask,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '시음일 : ',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                // controller.utils
                                //     .convFormatYmdKo(drinkYmd.toString()),
                                drinkYmd,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          Text(
                            emptyYn == true
                                ? 'EMPTY'
                                : openDday != null
                                    ? 'OPEN D+' + openDday.toString()
                                    : 'NEW',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: '삭제',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                _alertDelete(id, imageUrl).show();
              },
            ),
          ],
        ),
      ),
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
                await controller.getInitData();
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
                        Get.back();
                      },
                      child: Text(
                        "확인",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ).show();
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

  Alert _alertCompleteBackup(String fileName) {
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
      title:
          '엑셀 백업이 완료되었습니다. 파일은 "내장메모리/Download"에 "' + fileName + '" 파일로 저장됩니다.',
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(30),
          color: kPrimaryColor,
          child: Text(
            "확인",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () async {
            Get.back();
          },
        ),
      ],
    );
  }

  Alert _alertCancelBackup() {
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
      title: '엑셀백업은 "전체"탭에서 필터가 "ALL"인 상태에서만 가능합니다',
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(30),
          color: kPrimaryColor,
          child: Text(
            "확인",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () async {
            Get.back();
          },
        ),
      ],
    );
  }
}
