import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/ui/pages/create_post_page.dart';
import 'package:mychat/ui/pages/create_story_page.dart';
import 'package:mychat/ui/widgets/page_widgets/profile/current_user_posts.dart';
import 'package:mychat/viewModel/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/new_user_model.dart';
import '../../viewModel/user_view_model.dart';
import '../constant/constant_style.dart';
import '../widgets/page_widgets/profile/head_profile.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  const ProfilePage({required this.userName,Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {




  @override
  Widget build(BuildContext context) {
    final _profileViewModel = Provider.of<ProfileViewModel>(context);
    final _userViewModel = Provider.of<UserViewModel>(context);

    if(_profileViewModel.currentState == ProfileViewState.busy){
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Loading...' ,
            style: ConstantStyle.appNames,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>  CreatePostPage(profileViewModel: _profileViewModel,)));
              },
              icon: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  useRootNavigator: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding:
                      const EdgeInsets.only(top: 5, left: 10, bottom: 5),
                      height: 210,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 38,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffadb5bd)),
                          ),
                          ListTile(
                            leading: const Icon(CupertinoIcons.archivebox),
                            title: Text(
                              'Archive',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(CupertinoIcons.photo),
                            title: Text(
                              'Your posts',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Log out',
                              style: GoogleFonts.lato(color: Colors.red),
                            ),
                            onTap: () {
                              _userViewModel.signOut();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                CupertinoIcons.list_bullet,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: const Center(child: CircularProgressIndicator(),),
      );
    }
    else if(_profileViewModel.currentState == ProfileViewState.idle){
      NewUserModel? currentUser  = _profileViewModel.currentUser;
      return Scaffold(
          appBar: AppBar(
            title: Text(
              currentUser!.userName!,
              style: ConstantStyle.appNames,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26))),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding:
                            const EdgeInsets.only(top: 5, left: 0, bottom: 5),
                        height: 190,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              height: 1,
                            ),
                            Container(
                              width: 38,
                              height: 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffadb5bd)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Create',
                              style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(height: 3),
                            ListTile(
                              leading: const Icon(CupertinoIcons.photo),
                              contentPadding: const EdgeInsets.only(left: 25),
                              title: Text(
                                'Post',
                                style: GoogleFonts.lato(),
                              ),
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) =>  CreatePostPage(profileViewModel: _profileViewModel,)));
                              },
                            ),
                            ListTile(
                              leading: const Icon(CupertinoIcons.photo_camera),
                              contentPadding: const EdgeInsets.only(left: 25),
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) =>  CreateStoryPage(profileViewModel: _profileViewModel,)));
                              },
                              title: Text(
                                'Story',
                                style: GoogleFonts.lato(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  CupertinoIcons.add_circled,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26))),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding:
                        const EdgeInsets.only(top: 5, left: 10, bottom: 5),
                        height: 210,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 38,
                              height: 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffadb5bd)),
                            ),
                            ListTile(
                              leading: const Icon(CupertinoIcons.archivebox),
                              title: Text(
                                'Archive',
                                style: GoogleFonts.lato(),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(CupertinoIcons.photo),
                              title: Text(
                                'Your posts',
                                style: GoogleFonts.lato(),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Log out',
                                style: GoogleFonts.lato(color: Colors.red),
                              ),
                              onTap: () {
                                _userViewModel.signOut();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  CupertinoIcons.list_bullet,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                HeadProfile(
                  currentUser: currentUser,
                  profileViewModel: _profileViewModel,
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: CurrentUserPosts(
                  profileViewModel: _profileViewModel,
                ))
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.userName,
            style: ConstantStyle.appNames,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>  CreatePostPage(profileViewModel: _profileViewModel,)));
              },
              icon: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  useRootNavigator: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding:
                      const EdgeInsets.only(top: 5, left: 10, bottom: 5),
                      height: 210,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 38,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffadb5bd)),
                          ),
                          ListTile(
                            leading: const Icon(CupertinoIcons.archivebox),
                            title: Text(
                              'Archive',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(CupertinoIcons.photo),
                            title: Text(
                              'Your posts',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Log out',
                              style: GoogleFonts.lato(color: Colors.red),
                            ),
                            onTap: () {
                              _userViewModel.signOut();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                CupertinoIcons.list_bullet,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: const Center(child: Text('Something go wrong'),),
      );
    }
  }
}
