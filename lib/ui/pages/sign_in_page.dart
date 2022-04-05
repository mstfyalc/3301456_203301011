import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../viewModel/user_view_model.dart';
import '../constant/constant_color.dart';
import '../constant/constant_style.dart';
import '../widgets/page_widgets/sign_In/apple_button.dart';
import '../widgets/page_widgets/sign_In/email_and_password.dart';
import '../widgets/page_widgets/sign_In/google_button.dart';
import '../widgets/page_widgets/sign_In/microsoft_button.dart';
import '../widgets/page_widgets/sign_In/or_text.dart';
import '../widgets/page_widgets/sign_In/sign_in_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: SignInText(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: EmailAndPassword(
                    userViewModel: _userViewModel,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 35),
                  child: OrText(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 3),
                  child: GoogleButton(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  child: MicrosoftButton(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 30),
                  child: AppleButton(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 0),
                  child: Text(
                    'Need to help?',
                    style: GoogleFonts.lato(
                        color: ConstantColor.appColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField userInfoTextField(TextEditingController controller,
      TextInputType keyboardType, InputDecoration decoration, String value) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: decoration,
      onSubmitted: (enteredValue) {
        value = enteredValue;
      },
    );
  }

  ElevatedButton actionButton(UserViewModel userViewModel, String email,
      String password, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          userViewModel.signInWithEmailAndPassword(email, password);
          Navigator.pushNamed(context, '/homePage');
        },
        style: ConstantStyle.signInButtonStyle,
        child: const Text(
          'Log in',
          textAlign: TextAlign.center,
        ));
  }
}
