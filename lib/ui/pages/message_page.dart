import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../model/chat_profile_model.dart';
import '../../model/message_model.dart';
import '../../model/new_user_model.dart';

import '../../viewModel/user_view_model.dart';
import '../constant/constant_color.dart';

class MessagePage extends StatefulWidget {
  final NewUserModel currentUser;
  final NewUserModel userToMessage;

  const MessagePage(
      {required this.currentUser, required this.userToMessage, Key? key})
      : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    NewUserModel _currentUser = widget.currentUser;
    NewUserModel _userToMessage = widget.userToMessage;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 15),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.black,
                        size: 28,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage:
                    NetworkImage(widget.userToMessage.profileImageUrl!),
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userToMessage.name!,
                        style: GoogleFonts.lato(fontSize: 17),
                      ),
                      Text(
                        widget.userToMessage.userName!,
                        style:
                        GoogleFonts.lato(fontSize: 13, color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: _userViewModel.getMessages(
                      _currentUser.userId, _userToMessage.userId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MessageModel>> snapShots) {
                    if (!snapShots.hasData) {
                      return const Center(
                        child: Text('No message yet'),
                      );
                    } else if (snapShots.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    } else {
                      List<MessageModel> messageList = snapShots.data!;
                      return ListView.builder(
                          reverse: true,
                          itemCount: messageList.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            MessageModel _currentMessage = messageList[index];
                            return createCustomMessageStyle(_currentMessage);
                          });
                    }
                  },
                )),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 7, right: 10),
              margin: const EdgeInsets.only(right: 7, left: 7, bottom: 10),
              decoration: BoxDecoration(
                  color: const Color(0xffE8EAED),
                  borderRadius: BorderRadius.circular(28)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ConstantColor.appColor,
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Scrollbar(
                        child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          controller: _messageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Message...',
                          ),
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(3),
                    child: const Icon(
                      CupertinoIcons.photo,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_messageController.text
                          .trim()
                          .isNotEmpty) {
                        MessageModel _messageModelToSend = MessageModel(
                          to: _userToMessage.userId,
                          from: _currentUser.userId,
                          isFromMe: true,
                          message: _messageController.text,
                        );
                        _messageController.clear();
                        _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 10),
                            curve: Curves.easeOut);
                        ChatProfileModel _chatProfileModel = ChatProfileModel(
                            toName: widget.userToMessage.name!,
                            toProfile: widget.userToMessage.profileImageUrl!,
                            fromName: widget.currentUser.name!,
                            fromProfile: widget.currentUser.profileImageUrl!);
                        saveMessage(_messageModelToSend, _userViewModel,_chatProfileModel);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ConstantColor.appColor,
                          borderRadius: BorderRadius.circular(23)),
                      padding: const EdgeInsets.all(3),
                      child: const Icon(
                        CupertinoIcons.arrow_up_right,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveMessage(MessageModel message, UserViewModel userViewModel,
      ChatProfileModel chatProfileModel) async {
    await userViewModel.saveMessage(message, chatProfileModel);
  }

  Widget createCustomMessageStyle(MessageModel currentMessage) {
    Color senderBackgroundColor = const Color(0xffCE49BF);
    Color receiverBackgroundColor = const Color(0xffE8EAED);
    Color senderTextColor = Colors.white;
    Color receiverTextColor = Colors.black;

    bool isFromMe = currentMessage.isFromMe;

    String showDate = '';

    try {
      showDate = showHourAndMin(currentMessage.date);
    } catch (e) {
      debugPrint('e : ' + e.toString(),);
    }


    if (isFromMe) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              //alignment: Alignment.center,
                constraints: const BoxConstraints(minWidth: 50, maxWidth: 320),
                padding:
                const EdgeInsets.only(top: 13, right: 20, left: 20, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.zero,
                    bottomRight: Radius.circular(20),
                  ),
                  color: receiverBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currentMessage.message,
                      style: GoogleFonts.lato(color: receiverTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                          wordSpacing: 0.5),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 2,),
                    Text(showDate, style: GoogleFonts.lato(fontSize: 12),)

                  ],
                )
            ),


          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              //alignment: Alignment.center,
              constraints: const BoxConstraints(minWidth: 50, maxWidth: 320,),
              padding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.zero,
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5b3894),
                      Color(0xFF8e6bc7),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                color: senderBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currentMessage.message,
                    style: GoogleFonts.lato(color: senderTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                        wordSpacing: 0.5),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 2,),
                  Text(showDate,
                    style: GoogleFonts.lato(fontSize: 12, color: Colors.white),)

                ],
              ),
            )
          ],
        ),
      );
    }
  }

  String showHourAndMin(Timestamp? date) {
    var dateFormatter = DateFormat.Hm();
    var messageDate = dateFormatter.format(date!.toDate());
    return messageDate;
  }
}
