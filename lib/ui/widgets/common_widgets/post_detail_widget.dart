import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/model/new_user_model.dart';
import 'package:mychat/model/post_like_model.dart';
import 'package:mychat/ui/pages/comment_page.dart';
import 'package:mychat/viewModel/user_detail_view-model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../model/post_model.dart';
import '../../../viewModel/user_view_model.dart';
import '../../pages/user_detail_page.dart';

class PostDetailWidget extends StatefulWidget {
  final PostModel currentPost;
  final NewUserModel currentUser;

  const PostDetailWidget(
      {required this.currentUser, required this.currentPost, Key? key})
      : super(key: key);

  @override
  State<PostDetailWidget> createState() => _PostDetailWidgetState();
}

class _PostDetailWidgetState extends State<PostDetailWidget> {
  @override
  Widget build(BuildContext context) {

    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);


    PostModel currentPost = widget.currentPost;
    DateTime postDateTime = currentPost.createdAt!;
    String postDate = timeago.format(postDateTime);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(currentPost.fromImageUrl),
                      radius: 16,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      currentPost.fromName,
                      style: GoogleFonts.lato(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                            create: (BuildContext context) =>
                                UserDetailViewModel(currentPost.fromId),
                            child: UserDetailPage(
                              userName: currentPost.fromName,
                            ),
                          )));
                },
              ),
              Column(
                children: [
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.black),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
        Hero(
          tag: currentPost.postId!,
          child: Container(
            width: double.infinity,
            height: 480,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(currentPost.postUrl),
                    fit: BoxFit.cover)),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 3, right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: const Icon(
                      CupertinoIcons.heart,
                      size: 28,
                    ),
                    onTap: () async {
                      PostLikeModel postLikeModel = PostLikeModel(
                          postId: currentPost.postId!,
                          userId: widget.currentUser.userId,
                          userName: widget.currentUser.userName!,
                          profileImageUrl: widget.currentUser.profileImageUrl!);

                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                              builder: (context) => CommentPage(
                                    postId: currentPost.postId!,
                                    currentUser: widget.currentUser,
                                  )));
                    },
                    child: const Icon(
                      CupertinoIcons.bubble_left,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const Icon(
                CupertinoIcons.share_up,
                size: 23,
              )
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 3, bottom: 0, left: 15, right: 15),
          child: Row(
            children: [
              Text(
                currentPost.likes.toString() + ' likes',
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 3, bottom: 0, left: 15, right: 15),
          child: Row(
            children: [
              Text(currentPost.fromName,
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(
                width: 10,
              ),
              Text(currentPost.description ?? '',
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w400))
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 3, bottom: 15, left: 15, right: 15),
          child: Row(
            children: [
              Text(
                postDate,
                style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }




}
