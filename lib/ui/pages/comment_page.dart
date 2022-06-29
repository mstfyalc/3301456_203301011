import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/model/comment_model.dart';
import 'package:mychat/model/new_user_model.dart';
import 'package:mychat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../constant/constant_color.dart';

class CommentPage extends StatefulWidget {
  final String postId;
  final NewUserModel currentUser;

  const CommentPage({required this.currentUser, required this.postId, Key? key})
      : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.black,
                        size: 23,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Comments',
                    style: GoogleFonts.lato(fontSize: 21, color: Colors.black),
                  )
                ],
              ),

              //Show comments
              Expanded(child: StreamBuilder(
                stream: _userViewModel.getAllCommentsByPostId(widget.postId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CommentModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No Posts Yet'),
                      );
                    } else if (snapshot.hasData) {
                      List<CommentModel>? commentList = snapshot.data;

                      return commentList!.isNotEmpty
                          ? ListView.builder(
                        itemCount: commentList.length,
                        itemBuilder: (context,index){
                          CommentModel currentComment = commentList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                currentComment.fromImgUrl
                              ),
                            ),
                            title: Text(currentComment.fromUserName),
                            subtitle: Text(currentComment.comment),
                            trailing: const Text('1g'),
                          );


                        },

                      )
                          : const Center(
                        child: Text('Not comment yet.'),
                      );
                    } else {
                      return const Center(
                        child: Text('something go wrong'),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text('Connection error'),
                    );
                  }
                },
              )),

              //Add Comment
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 7, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.3))),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.currentUser.profileImageUrl!),
                          radius: 18,
                        )
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Scrollbar(
                          child: TextField(
                            minLines: 1,
                            maxLines: 5,
                            controller: commentController,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add comment...',
                              hintStyle: GoogleFonts.lato(),
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                          padding: const EdgeInsets.all(3),
                          child: TextButton(
                              onPressed: () async {
                                CommentModel newCommentModel = CommentModel(
                                  postId: widget.postId,
                                  fromId: widget.currentUser.userId,
                                  fromUserName: widget.currentUser.userName!,
                                  fromImgUrl: widget.currentUser
                                      .profileImageUrl!,
                                  comment: commentController.text,
                                );
                                await saveComment(
                                    newCommentModel, _userViewModel);
                                if (commentController.text
                                    .trim()
                                    .isNotEmpty) {
                                  commentController.clear();
                                }
                              },
                              child: Text(
                                'Share',
                                style: GoogleFonts.lato(
                                    color: ConstantColor.appColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<void> saveComment(CommentModel commentModel,
      UserViewModel _userViewModel) async {
    await _userViewModel.saveComment(commentModel);
  }


}
