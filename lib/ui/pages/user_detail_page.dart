import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/ui/constant/constant_color.dart';
import 'package:mychat/ui/pages/message_page.dart';
import 'package:mychat/ui/widgets/page_widgets/user_detail/user_posts.dart';
import 'package:mychat/viewModel/user_detail_view-model.dart';
import 'package:mychat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/new_user_model.dart';


class UserDetailPage extends StatefulWidget {
  final String userName;

  const UserDetailPage({required this.userName, Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    final UserDetailViewModel _userDetailViewModel =
        Provider.of<UserDetailViewModel>(context);
    final UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    if (_userDetailViewModel.currentViewState == UserDetailViewState.busy) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.userName,
            style: GoogleFonts.lato(fontSize: 21, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black, size: 23),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_userDetailViewModel.currentViewState ==
        UserDetailViewState.idle) {
      NewUserModel? userToDetail = _userDetailViewModel.currentUser;
      NewUserModel? currentUser = _userViewModel.userModel;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            userToDetail!.userName!,
            style: GoogleFonts.lato(fontSize: 21, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black, size: 23),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: userToDetail.userId,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userToDetail.profileImageUrl!),
                        radius: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    getInfo('127', 'Post'),
                    const SizedBox(
                      width: 5,
                    ),
                    getInfo('2,5M', 'Followers'),
                    const SizedBox(
                      width: 5,
                    ),
                    getInfo('150', 'Follow'),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                userToDetail.name!,
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: Text(
                userToDetail.description ?? '',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Text(
                          'Follow',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: ConstantColor.appColor,
                            border: Border.all(
                                width: 1, color: const Color(0xffdee2e6))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => MessagePage(
                                      userToMessage: userToDetail,
                                      currentUser: currentUser!,
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Text(
                          'Message',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                width: 1, color: const Color(0xffdee2e6))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              width: 1, color: const Color(0xffdee2e6))),
                      child: const Icon(CupertinoIcons.person_add),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(child: UserPosts(userDetailViewModel: _userDetailViewModel,))









          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.userName,
            style: GoogleFonts.lato(fontSize: 21, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black, size: 23),
        ),
        body: const Center(
          child: Text('Something go wrong'),
        ),
      );
    }
  }

  Column getInfo(String count, String description) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(description,
            style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 15))
      ],
    );
  }
}
