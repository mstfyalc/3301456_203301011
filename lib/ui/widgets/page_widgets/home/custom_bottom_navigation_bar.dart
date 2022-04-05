import 'package:flutter/cupertino.dart';
import 'package:mychat/model/new_user_model.dart';

import '../../../constant/constant_color.dart';
import '../../../functions/tab_items.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> selectedTab;
  final Map<TabItem, Widget> allPages;
  final Map<TabItem, GlobalKey<NavigatorState>> allNavigatorsKey;
  final NewUserModel? currentUser;

  const CustomBottomNavigationBar({required this.allPages,
    required this.selectedTab,
    required this.currentTab,

    required this.allNavigatorsKey,
    required this.currentUser,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _navigationBarItem(TabItem.chats),
          _navigationBarItem(TabItem.search),
          _navigationBarItem(TabItem.posts),
          _navigationBarItem(TabItem.profile),
        ],
        onTap: (index) => selectedTab(TabItem.values[index]),
        activeColor: ConstantColor.appColor,
      ),
      tabBuilder: (context, index) {
        final itemToShow = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: allNavigatorsKey[itemToShow],
          builder: (context) {
            return allPages[itemToShow]!;
          },
        );
      },
    );
  }

  BottomNavigationBarItem _navigationBarItem(TabItem tabItem) {
    final tabToCreate = TabItemData.allTabs[tabItem];


    if (tabToCreate != null) {
      return BottomNavigationBarItem(
        icon: tabToCreate.icon,

      );
    } else {
      return const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled), label: 'Null');
    }
  }
}
