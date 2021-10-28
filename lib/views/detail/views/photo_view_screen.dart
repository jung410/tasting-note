import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';

class PhotoViewScreen extends StatelessWidget {
  static String routeName = "/photo_view";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: PhotoView(
          initialScale: PhotoViewComputedScale.contained,
          maxScale: 3.0,
          minScale: PhotoViewComputedScale.contained,
          imageProvider: NetworkImage(Get.arguments),
        ),
      ),
    );
  }
}
