import 'package:flutter/material.dart';

import '../../../constant/constant_style.dart';


class SignInText extends StatelessWidget {
  const SignInText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Log in',style: ConstantStyle.signInTextStyle,textAlign: TextAlign.center,);
  }
}
