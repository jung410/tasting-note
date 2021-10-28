import 'package:flutter/material.dart';

import 'components/body.dart';

class StartScreen extends StatelessWidget {
  static String routeName = "/start";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
