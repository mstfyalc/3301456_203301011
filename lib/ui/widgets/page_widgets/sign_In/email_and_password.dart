import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../viewModel/user_view_model.dart';
import '../../../constant/constant_style.dart';
import '../../../exception/sign_exception.dart';
import '../../common_widgets/alert_dialog.dart';

enum FormType { signIn, signUp }

class EmailAndPassword extends StatefulWidget {
  final UserViewModel userViewModel;


  const EmailAndPassword({required this.userViewModel, Key? key})
      : super(key: key);

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  //Variables
  String _email = '', _password = '';
  String _buttonText = '';
  String _helpText = '';
  FormType _formType = FormType.signIn;

  //GlobalFormKey
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();
  final ConstantStyle _constantStyle = ConstantStyle();

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.signIn ? 'Sign In' : 'Sign Up';
    _helpText = _formType == FormType.signIn
        ? '  New here?  '
        : '  Already have an account?  ';

    return Form(
      key: _formGlobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: _constantStyle
                  .signInEmailFieldDecoration(widget.userViewModel.emailError),
              onSaved: (String? enteredEmail) {
                _email = enteredEmail!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: _constantStyle.signInPasswordFieldDecoration(
                  widget.userViewModel.passwordError),
              onSaved: (String? enteredPassword) {
                _password = enteredPassword!;
              },
            ),
          ),
          SizedBox(
            width: 315,
            height: 50,
            child: ElevatedButton(
                onPressed: () => _formSubmit(context),
                style: ConstantStyle.signInButtonStyle,
                child: Text(
                  _buttonText,
                  textAlign: TextAlign.center,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _formType = _formType == FormType.signIn
                      ? FormType.signUp
                      : FormType.signIn;
                });
              },
              child: Text(
                _helpText,
                style: ConstantStyle.signTextStyle,
              ),
            ),
          )
        ],
      ),
    );
  }

  _formSubmit(BuildContext context) async {
    bool isFormValid = _formGlobalKey.currentState!.validate();
    if (isFormValid) {
      _formGlobalKey.currentState!.save();
      if (_formType == FormType.signIn) {
        try {
          await widget.userViewModel
              .signInWithEmailAndPassword(_email, _password);
        } on FirebaseException catch (e) {
          showDialog(
              context:  context,
              builder: (context) {
                return SensitiveAlertDialog(
                  pageContext: context,
                  title: '',
                  content: Text(SignException.showException(e.code)),
                  cancelButtonText: null,
                  okButtonText: 'Ok',
                );
              });
        }
      } else {
        try {
          await widget.userViewModel
              .signUpWithEmailAndPassword(_email, _password);
        } on FirebaseException catch (e) {
          showDialog(
              context: context,
              builder: (context) {
                return SensitiveAlertDialog(
                  pageContext: context,
                  title: '',
                  content: Text(SignException.showException(e.code)),
                  cancelButtonText: null,
                  okButtonText: 'Ok',
                );
              });
        }
      }
    } else {}
  }
}
