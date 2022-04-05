import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../viewModel/user_view_model.dart';
import '../../../constant/constant_style.dart';
import '../../../pages/home_page.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {



  @override
  Widget build(BuildContext context) {

    final userViewModel = Provider.of<UserViewModel>(context);

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
            decoration: ConstantStyle.googleButtonsBoxDecorationStyle,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () async {
                final _user = await userViewModel.signInWithGoogle();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userModel: _user)));
              },
              child: const Text('Continue with google'))
        ],
      ),
    );
  }
}
