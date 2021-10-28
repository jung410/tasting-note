import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testing_note/utils/util.dart';
import 'package:testing_note/views/main/model/wine.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class MainController extends GetxController with SingleGetTickerProviderMixin {
  static MainController get to => Get.find();

  final storage = GetStorage('user');

  CommUtils utils = CommUtils();

  RxBool isLoading = false.obs;
  bool isInit = false;

  int dropBoxValue;
  int scoreDropBoxValue;
  int score;

  TextEditingController searchTextController = new TextEditingController();
  TabController tabController;
  RxInt tabValue = 0.obs;

  GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  RxList<Wine> wineList = <Wine>[].obs;
  RxList<Wine> emptyWineList = <Wine>[].obs;

  RxBool isScoreClick = false.obs;

  Directory downloadDirectory;

  @override
  void onInit() {
    isInit = true;
    tabController = new TabController(length: 2, vsync: this);
    dropBoxValue = 1;
    scoreDropBoxValue = 1;
    wineList([]);
    getInitData();
    super.onInit();
  }

  @override
  void onReady() {
  }

  Future<void> getInitData() async {
    downloadDirectory = await DownloadsPathProvider.downloadsDirectory;
    dropBoxValue = 1;
    scoreDropBoxValue = 1;
    wineList([]);
    emptyWineList([]);
    isLoading(true);
    try {
      final f = FirebaseFirestore.instance;

      var collection = f.collection('user');
      var querySnapshot = await collection.doc(await storage.read('pin')).collection('wine').orderBy('reg_dt', descending: true).get();

      Map<String, dynamic> tempMap = {};
      querySnapshot.docs.map((e) async {
        tempMap.addAll(e.data());
        tempMap['id'] = e.id;
        Wine wine = Wine.fromJson(tempMap);
        wineList.add(wine);
        if(tempMap['have_yn']){
          emptyWineList.add(wine);
        }
        // tempList.add(wine);
      }).toList();
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
    isLoading(false);
  }

  Future<void> getSearchData() async {
    emptyWineList([]);
    wineList([]);
    isLoading(true);
    try {
      final f = FirebaseFirestore.instance;

      var collection = f.collection('user');

      var querySnapshot;
      if(searchTextController.text != '') {
        querySnapshot = await collection.doc(await storage.read('pin'))
            .collection('wine')
            .where('name', isEqualTo: searchTextController.text)
            // .where('name', arrayContains: [searchTextController.text])
            .get();
      } else {
        querySnapshot = await collection.doc(await storage.read('pin')).collection('wine').orderBy('reg_dt', descending: true).get();
      }

      Map<String, dynamic> tempMap = {};
      querySnapshot.docs.map((e) async {
        tempMap.addAll(e.data());
        tempMap['id'] = e.id;
        Wine wine = Wine.fromJson(tempMap);
        wineList.add(wine);
        if(tempMap['empty_yn']){
          emptyWineList.add(wine);
        }
        // tempList.add(wine);
      }).toList();
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
    isLoading(false);
  }

  Future<void> dropBoxChange() async {
    if(tabValue == 0) {
      // emptyWineList([]);
      wineList([]);
      isLoading(true);
      try {
        final f = FirebaseFirestore.instance;

        var collection = f.collection('user');

        var querySnapshot;
        if(dropBoxValue == 1){
          querySnapshot = await collection.doc(await storage.read('pin'))
              .collection('wine')
              .orderBy('reg_dt', descending: true)
              .get();
        } else if(dropBoxValue == 2) {
          querySnapshot = await collection.doc(await storage.read('pin'))
              .collection('wine')
              .where('open_dt', isNotEqualTo: '')
              .get();
        } else if(dropBoxValue == 3) {
          querySnapshot = await collection.doc(await storage.read('pin'))
              .collection('wine')
              .where('open_dt', isEqualTo: '')
              .get();
        } else if(dropBoxValue == 4) {
          querySnapshot = await collection.doc(await storage.read('pin'))
              .collection('wine')
              .where('empty_yn', isEqualTo: true)
              .get();
        }

        Map<String, dynamic> tempMap = {};
        querySnapshot.docs.map((e) async {
          tempMap.addAll(e.data());
          tempMap['id'] = e.id;
          Wine wine = Wine.fromJson(tempMap);
          wineList.add(wine);
          // if(tempMap['empty_yn']){
          //   emptyWineList.add(wine);
          // }
          // tempList.add(wine);
        }).toList();
        isLoading(false);
      } catch (e) {
        isLoading(false);
      }
    } else if(tabValue == 1) {
      isLoading(true);
      try {
        emptyWineList([]);
        final f = FirebaseFirestore.instance;
        var collection = f.collection('user');
        var querySnapshot;
        querySnapshot = await collection.doc(await storage.read('pin'))
            .collection('wine')
            .orderBy('reg_dt', descending: true)
            .get();
        Map<String, dynamic> tempMap = {};
        querySnapshot.docs.map((e) async {
          tempMap.addAll(e.data());
          tempMap['id'] = e.id;
          Wine wine = Wine.fromJson(tempMap);
          // wineList.add(wine);
          if(tempMap['have_yn']){
            emptyWineList.add(wine);
          }
        }).toList();
        List<Wine> tempEmptyWineList = [];
        if (dropBoxValue == 1) {
          tempEmptyWineList.addAll(emptyWineList);
        } else if (dropBoxValue == 2) {
          for (int i = 0; i < emptyWineList.length; i++) {
            if (emptyWineList[i].openDt != '') {
              tempEmptyWineList.add(emptyWineList[i]);
            }
          }
        } else if (dropBoxValue == 3) {
          for (int i = 0; i < emptyWineList.length; i++) {
            if (emptyWineList[i].openDt == '') {
              tempEmptyWineList.add(emptyWineList[i]);
            }
          }
        } else if (dropBoxValue == 4) {
          for (int i = 0; i < emptyWineList.length; i++) {
            if (emptyWineList[i].emptyYn == 'Y') {
              tempEmptyWineList.add(emptyWineList[i]);
            }
          }
        }
        emptyWineList([]);
        emptyWineList.addAll(tempEmptyWineList);
      } catch (e) {
        isLoading(false);
      }
    }
    isLoading(false);
  }

  Future<void> scoreDropBoxChange() async {
    if(tabValue == 0) {
      wineList([]);
      isLoading(true);
      try {
        final f = FirebaseFirestore.instance;

        var collection = f.collection('user');

        var querySnapshot;

        querySnapshot = await collection.doc(await storage.read('pin'))
            .collection('wine')
            // .where('score', isGreaterThanOrEqualTo: score)
            .orderBy('reg_dt', descending: true)
            .get();

        Map<String, dynamic> tempMap = {};
        querySnapshot.docs.map((e) async {
          tempMap.addAll(e.data());
          tempMap['id'] = e.id;
          Wine wine = Wine.fromJson(tempMap);
          if(tempMap['score'] >= score){
            wineList.add(wine);
          }
        }).toList();
        isLoading(false);
      } catch (e) {
        isLoading(false);
      }
    } else if(tabValue == 1) {
      isLoading(true);
      try {
        emptyWineList([]);
        final f = FirebaseFirestore.instance;
        var collection = f.collection('user');
        var querySnapshot;
        querySnapshot = await collection.doc(await storage.read('pin'))
            .collection('wine')
            .orderBy('reg_dt', descending: true)
            .get();
        Map<String, dynamic> tempMap = {};
        querySnapshot.docs.map((e) async {
          tempMap.addAll(e.data());
          tempMap['id'] = e.id;
          Wine wine = Wine.fromJson(tempMap);
          if(tempMap['have_yn'] && (tempMap['score'] >= score)){
            emptyWineList.add(wine);
          }
        }).toList();
      } catch (e) {
        isLoading(false);
      }
    }
    isLoading(false);
  }

  @override
  void onClose() {
    searchTextController.clear();
    super.onClose();
  }
}
