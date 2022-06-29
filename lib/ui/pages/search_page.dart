import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/new_user_model.dart';
import '../../viewModel/user_detail_view-model.dart';
import '../constant/constant_style.dart';
import 'user_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchQ = TextEditingController();
  String? userName;

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.049,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                ),
                decoration: const BoxDecoration(
                    color: Color(0xffE0E0E0),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextField(
                  controller: searchQ,
                  onChanged: (q) {
                    setState(() {
                      userName = q;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Icon(CupertinoIcons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            userName == null || userName!.isEmpty
                ? const Center(
                    child: Text(''),
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
                                      if (user.userId !=
                                          _userViewModel.userModel!.userId) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                user.profileImageUrl!),
                                          ),
                                          title: Text(user.userName!),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(user.name!),
                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => ChangeNotifierProvider(
                                                  create: (BuildContext context) =>
                                                      UserDetailViewModel(user.userId),
                                                  child: UserDetailPage(
                                                    userName: user.userName!,
                                                  ),
                                                )));
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
            /*Expanded(
              child: Center(
                child: StreamBuilder<List<NewUserModel>>(
                  stream: _userViewModel.getAllUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NewUserModel>> snapShots) {
                    if (snapShots.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapShots.connectionState ==
                            ConnectionState.active ||
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
                                  backgroundImage:
                                      NetworkImage(user.profileImageUrl!),
                                ),
                                title: Text(user.userName!),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(user.name!),
                                    Text(user.createdAt!.hour.toString() +
                                        ':' +
                                        user.createdAt!.minute.toString())
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
            ),*/
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
