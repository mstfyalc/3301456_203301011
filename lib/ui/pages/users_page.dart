import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mychat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/new_user_model.dart';
import '../constant/constant_style.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All users',style: ConstantStyle.appNames,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xffc1c8c7),
            child: IconButton(
              onPressed: (){},
              icon: const Icon(CupertinoIcons.search,color: Colors.white,size: 20,),
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
      body: Center(
        child: StreamBuilder<List<NewUserModel>>(
          stream: _userViewModel.getAllUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<NewUserModel>> snapShots) {
            if (snapShots.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapShots.connectionState == ConnectionState.active ||
                snapShots.connectionState == ConnectionState.done) {
              if (snapShots.hasError) {
                return const Text('Error');
              } else if (snapShots.hasData) {
                return ListView.builder(
                    itemCount: snapShots.data!.length,
                    itemBuilder: (context, index) {
                      NewUserModel user = snapShots.data![index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(user.profileImageUrl!),),
                        title: Text(user.userName!),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(user.name!),
                            Text(user.createdAt!.hour.toString() + ':' +user.createdAt!.minute.toString())
                          ],
                        ),
                      );
                      });
              } else {
                return const Text('Empty data');
              }
            } else {
              return const Text('Connection error');
            }
          },
        ),
      ),
    );
  }
}
