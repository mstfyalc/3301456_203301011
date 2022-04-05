import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../model/new_user_model.dart';
import '../../viewModel/user_view_model.dart';
import '../constant/constant_style.dart';
import 'message_page.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({Key? key}) : super(key: key);

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  TextEditingController _queryController = TextEditingController();
  String? userName;

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'New message',
          style: ConstantStyle.newMessageStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Material(
              elevation: 1,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: TextField(
                  controller: _queryController,
                  onChanged: (q) {
                    setState(() {
                      userName = q;
                    });
                  },
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a name',
                      prefixText: 'To:  '),
                ),
              ),
            ),
            userName == null || userName!.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Column(
                  children: [
                    const Icon(CupertinoIcons.person_2, size: 50,),
                    const SizedBox(height: 10,),
                    Text('User Not found', style: GoogleFonts.lato(
                        fontSize: 18, color: Colors.black),)
                  ],
                ),
              ),
            )
                : Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child: StreamBuilder<List<NewUserModel>>(
                    stream: _userViewModel.getAllUsers(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<NewUserModel>> snapShots) {
                      if (snapShots.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapShots.connectionState ==
                          ConnectionState.active ||
                          snapShots.connectionState ==
                              ConnectionState.done) {
                        if (snapShots.hasError) {
                          return const Text('Error');
                        } else if (snapShots.hasData) {
                          List<NewUserModel>? filteredList =
                          filterUser(snapShots.data!, userName!);
                          return ListView.builder(
                              itemCount: filteredList!.length,
                              itemBuilder: (context, index) {
                                NewUserModel user = filteredList[index];
                                if(user.userId != _userViewModel.userModel!.userId){
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                      NetworkImage(user.profileImageUrl!),
                                    ),
                                    title: Text(user.userName!),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(user.name!),
                                        Text(user.createdAt!.hour
                                            .toString() +
                                            ':' +
                                            user.createdAt!.minute
                                                .toString())
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(MaterialPageRoute(
                                          builder: (context) =>  MessagePage(currentUser: _userViewModel.userModel!,userToMessage: user,)));
                                    },
                                  );
                                }
                                return Container();
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
              ),
            )
          ],
        ),
      ),
    );
  }

  List<NewUserModel>? filterUser(List<NewUserModel> userList, String q) {
    List<NewUserModel>? filteredUserList =
    userList.where((element) => element.userName!.contains(q)).toList();
    return filteredUserList;
  }
}
