import 'package:flutter/material.dart';
import 'package:mychat/viewModel/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/new_user_model.dart';

import '../../viewModel/post_view_model.dart';
import '../functions/tab_items.dart';
import '../widgets/page_widgets/home/custom_bottom_navigation_bar.dart';
import 'chats_page.dart';
import 'profile_page.dart';
import 'posts_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  final NewUserModel? userModel;

  const HomePage({required this.userModel, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.chats;

  Map<TabItem, Widget> allPages() {
    return {
      TabItem.chats: const ChatsPage(),
      TabItem.search: const SearchPage(),
      TabItem.posts: ChangeNotifierProvider(
        create: (BuildContext context) => PostViewModel(),
        child:  const PostsPage(),
      ),
      TabItem.profile: ChangeNotifierProvider(
        create: (BuildContext context) => ProfileViewModel(),
        child:  ProfilePage(userName: widget.userModel!.userName!,),
      ),
    };
  }

  Map<TabItem, GlobalKey<NavigatorState>> allNavigatorsKey = {
    TabItem.chats: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.posts: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: CustomBottomNavigationBar(
          allNavigatorsKey: allNavigatorsKey,
          allPages: allPages(),
          currentTab: _currentTab,
          currentUser: widget.userModel,
          selectedTab: (TabItem selectedTab) {
            if (selectedTab == _currentTab) {
              allNavigatorsKey[selectedTab]!
                  .currentState!
                  .popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _currentTab = selectedTab;
              });
            }
          },
        ),
        onWillPop: () async =>
            !await allNavigatorsKey[_currentTab]!.currentState!.maybePop());
  }
}
