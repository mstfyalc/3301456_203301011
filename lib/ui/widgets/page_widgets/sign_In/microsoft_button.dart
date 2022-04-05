import 'package:flutter/material.dart';

import '../../../constant/constant_style.dart';

class MicrosoftButton extends StatefulWidget {
  const MicrosoftButton({Key? key}) : super(key: key);

  @override
  State<MicrosoftButton> createState() => _MicrosoftButtonState();
}

class _MicrosoftButtonState extends State<MicrosoftButton> {
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
            width: 20,
            height: 20,
            decoration: ConstantStyle.microsoftButtonsBoxDecorationStyle,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {}, child: const Text('Continue with microsoft'))
        ],
      ),
    );
  }
}
