import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'platform_sensitive_widget.dart';

class SensitiveAlertDialog extends PlatformSensitiveWidget {
  const SensitiveAlertDialog(
      {required this.title,
      required this.pageContext,
      required this.cancelButtonText,
      required this.content,
      required this.okButtonText,
      Key? key})
      : super(key: key);

  final String title;
  final Widget content;
  final String okButtonText;
  final String? cancelButtonText;
  final BuildContext pageContext;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: content,
      actions: _alertDialogAction(pageContext),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: _alertDialogAction(pageContext),
    );
  }

  List<Widget> _alertDialogAction(BuildContext context) {
    List<Widget> allActions = [];

    if (Platform.isIOS) {
      allActions.add(CupertinoDialogAction(
        child: Text(okButtonText),
        onPressed: () {
          Navigator.pop(context);
        },
      ));
      if (cancelButtonText != null) {
        allActions.add(CupertinoDialogAction(
          child: Text(cancelButtonText!),
          onPressed: () {},
        ));
      }
    } else {
      allActions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(okButtonText)));
      if (cancelButtonText != null) {
        allActions
            .add(TextButton(onPressed: () {}, child: Text(cancelButtonText!)));
      }
    }

    return allActions;
  }
}
