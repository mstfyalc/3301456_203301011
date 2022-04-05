import 'package:flutter/material.dart';

import '../../../constant/constant_style.dart';

class AppleButton extends StatefulWidget {
  const AppleButton({Key? key}) : super(key: key);

  @override
  State<AppleButton> createState() => _AppleButtonState();
}

class _AppleButtonState extends State<AppleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      height: 50,
      decoration: ConstantStyle.sigInProviderButtonsBoxDecorationStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            decoration: ConstantStyle.appleButtonsBoxDecorationStyle,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {}, child: const Text('Continue with apple'))
        ],
      ),
    );
  }
}
