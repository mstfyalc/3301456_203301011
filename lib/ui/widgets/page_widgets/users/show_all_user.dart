import 'package:flutter/material.dart';
import 'package:mychat/model/new_user_model.dart';
import 'package:provider/provider.dart';


class ShowAllUser extends StatefulWidget {
  const ShowAllUser({Key? key}) : super(key: key);

  @override
  State<ShowAllUser> createState() => _ShowAllUserState();
}

class _ShowAllUserState extends State<ShowAllUser> {
  @override
  Widget build(BuildContext context) {
    List<NewUserModel> _allUser = Provider.of<List<NewUserModel>>(context);

    return ListView.builder(
        itemCount: _allUser.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: _allUser.map((user) => ListTile(title: Text(user.name!),)).toList(),
              ),)


    );
  }
}
