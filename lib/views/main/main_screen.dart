import 'package:flutter/material.dart';
import 'package:testing_note/views/main/components/body.dart';

class MainScreen extends StatelessWidget {
  static String routeName = "/main";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
