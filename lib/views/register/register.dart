import 'package:flutter/material.dart';
import 'package:testing_note/views/register/components/body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/register";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Body(),
    );
  }
}
