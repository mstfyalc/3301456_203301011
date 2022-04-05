import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/constant_style.dart';


class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context){
            return IconButton(
              onPressed: (){},
              icon: const Icon(CupertinoIcons.person,color: Colors.grey,size: 30,),
            );
          },
        ),
        title: Text('Posts',style: ConstantStyle.appNames,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xffc1c8c7),
            child: IconButton(
              onPressed: (){},
              icon: const Icon(Icons.contacts,color: Colors.white,size: 20,),
            ),
          ),
          const SizedBox(width: 10,),



        ],
      ),
    );
  }
}
