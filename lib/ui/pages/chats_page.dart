import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mychat/ui/constant/constant_color.dart';
import 'package:mychat/ui/pages/show_stories_page.dart';
import 'package:provider/provider.dart';

import '../../model/conversations_model.dart';
import '../../model/new_user_model.dart';
import '../../model/story_model.dart';
import '../../viewModel/user_view_model.dart';
import '../constant/constant_style.dart';
import 'message_page.dart';
import 'new_message_page.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    NewUserModel? currentUser = _userViewModel.userModel;
    //TextEditingController _conversationsSearchQuery = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'MyChat\'s',
          style: ConstantStyle.appNames,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xff000000),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.camera_fill,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xff000000),
            child: IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => const NewMessagePage()));
              },
              icon: const Icon(
                CupertinoIcons.pencil,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:  const EdgeInsets.only(top: 15, bottom: 20, left: 10,right:10),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20,right:10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.05,
              decoration: const BoxDecoration(
                color : Color(0xffE8E8E8),
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search in chat\'s...', style: GoogleFonts.lato(fontSize: 16,color: const Color(0xff888888)),),
                  const Icon(CupertinoIcons.search,color:  Color(0xff888888))
                ],
              ),
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 25, left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: _userViewModel.getAllStories(),
                builder: (BuildContext context,  AsyncSnapshot<List<StoryModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if (snapshot.connectionState ==
                      ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No talks'),
                      );
                    } else if (snapshot.hasData) {
                      List<StoryModel> allStories = snapshot.data!;
                      return allStories.isNotEmpty
                          ? Container(
                        child: ListView.builder(
                            itemCount: allStories.length,
                            itemBuilder: (context, index) {
                              StoryModel currentStory =
                              allStories[index];
                              return GestureDetector(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: ConstantColor.appColor, width: 1.5),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(60))),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: CircleAvatar(
                                      radius: 26,
                                      backgroundImage: NetworkImage(
                                          currentStory.fromImageUrl),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.of(context, rootNavigator: true).push(
                                      MaterialPageRoute(
                                          builder: (context) =>  ShowStoriesPage(currentStory: currentStory,)));
                                },
                              );
                            }),
                      )
                          : emptyConversations(context);
                    } else {
                      return const Center(
                        child: Text('Something go wrong'),
                      );
                    }
                  }else {
                    return const Center(
                      child: Text('Connection error'),
                    );
                  }
                }
              ),
            ),
          ),*/
          Expanded(
            child: StreamBuilder(
              stream: _userViewModel.getAllConversations(currentUser!.userId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ConversationsModel>> snapShots) {
                if (snapShots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapShots.connectionState ==
                        ConnectionState.active ||
                    snapShots.connectionState == ConnectionState.done) {
                  if (snapShots.hasError) {
                    return const Text('Error');
                  } else if (!snapShots.hasData) {
                    return const Center(
                      child: Text('No talks'),
                    );
                  } else if (snapShots.hasData) {
                    List<ConversationsModel> allConversations = snapShots.data!;
                    return allConversations.isNotEmpty
                        ? Center(
                            child: ListView.builder(
                                itemCount: allConversations.length,
                                itemBuilder: (context, index) {
                                  ConversationsModel currentConversation =
                                      allConversations[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          currentConversation.toProfile),
                                    ),
                                    title: Text(currentConversation.toName),
                                    subtitle:
                                        Text(currentConversation.lastMessage),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            showHourAndMin(
                                                currentConversation.createdAt),
                                            style:
                                                GoogleFonts.lato(fontSize: 12)),
                                      ],
                                    ),
                                    onTap: () {
                                      redirectToMessagePage(
                                          context,
                                          currentConversation.toWho,
                                          _userViewModel);
                                    },
                                  );
                                }),
                          )
                        : emptyConversations(context);
                  } else {
                    return const Center(
                      child: Text('Something go wrong'),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Connection error'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void redirectToMessagePage(BuildContext context, String idToMessageUser,
      UserViewModel userViewModel) async {
    NewUserModel? userToMessage =
        await userViewModel.getUserById(idToMessageUser);
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => MessagePage(
              userToMessage: userToMessage!,
              currentUser: userViewModel.userModel!,
            )));
  }

  Widget emptyConversations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: GoogleFonts.lato(
                  fontSize: 26,
                  color: const Color(0xff6c757d),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tap',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.pencil,
                      color: Color(0xff495057),
                    )),
                Text('to send a message.',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tap',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.person_2_fill,
                      color: Color(0xff495057),
                    )),
                Text('to find people.',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tap',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.camera_on_rectangle_fill,
                      color: Color(0xff495057),
                    )),
                Text('to view stories.',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tap',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.person_fill,
                      color: Color(0xff495057),
                    )),
                Text('to edit profile.',
                    style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color(0xff6c757d),
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget searchInConversation(TextEditingController controller) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
      child: Text('Fuck u'),
    );
  }

  String showHourAndMin(Timestamp? date) {
    var dateFormatter = DateFormat.Hm();
    var messageDate = dateFormatter.format(date!.toDate());
    return messageDate;
  }

  List<ConversationsModel> filteredList(
      List<ConversationsModel> allConversation, String q) {
    List<ConversationsModel> filteredList = allConversation
        .where((conversation) => conversation.fromName.contains(q))
        .toList();
    return filteredList;
  }
}
