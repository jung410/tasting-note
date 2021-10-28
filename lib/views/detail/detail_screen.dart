import 'package:flutter/material.dart';
import 'package:testing_note/views/detail/components/body.dart';

class DetailScreen extends StatelessWidget {
  static String routeName = "/detail";

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
