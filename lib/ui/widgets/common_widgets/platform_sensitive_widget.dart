
import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformSensitiveWidget extends StatelessWidget{
  const PlatformSensitiveWidget({Key? key}) : super(key: key);


  Widget buildMaterialWidget(BuildContext context);
  Widget buildCupertinoWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return buildCupertinoWidget(context);
    }
    return buildMaterialWidget(context);
  }


}