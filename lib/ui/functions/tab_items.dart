import 'package:flutter/cupertino.dart';


enum TabItem { chats, search, posts, profile }


class TabItemData {


  final Widget icon;


  TabItemData({required this.icon});

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.chats: TabItemData(
        icon: const Icon(CupertinoIcons.chat_bubble_2_fill)),
    TabItem.search: TabItemData(icon: const Icon(CupertinoIcons.search)),
    TabItem.posts: TabItemData(
        icon: const Icon(CupertinoIcons.camera_on_rectangle_fill)),
    TabItem.profile: TabItemData(
      icon: const Icon(CupertinoIcons.profile_circled),),
  };


}