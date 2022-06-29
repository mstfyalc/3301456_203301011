import 'package:flutter/material.dart';
import 'package:mychat/ui/pages/sign_in_page.dart';
import 'package:provider/provider.dart';

import '../../viewModel/user_view_model.dart';
import 'home_page.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);

    if (_userViewModel.viewState == ViewState.idle) {
      if (_userViewModel.userModel == null) {
        return const SignInPage();
      } else {
        return  HomePage(userModel: _userViewModel.userModel,);
      }
    } else {
      return const Scaffold(
        body: Center(
          child:CircularProgressIndicator(),),
      );
    }
  }
}
