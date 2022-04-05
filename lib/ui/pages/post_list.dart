import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/ui/constant/constant_color.dart';
import 'package:mychat/viewModel/profile_view_model.dart';

import '../../model/post_model.dart';

class PostList extends StatefulWidget {
  final ProfileViewModel profileViewModel;

  const PostList({required this.profileViewModel, Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black,
                      size: 24,
                    )),
                Text(
                  'Posts',
                  style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
            Expanded(
                child: StreamBuilder(
                  stream: widget.profileViewModel.getPostsByUserId(
                      widget.profileViewModel.currentUser!.userId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PostModel>> snapShots) {
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
                        List<PostModel> allPosts = snapShots.data!;
                        return ListView.builder(
                            itemCount: allPosts.length,
                            itemBuilder: (context, index) {
                              PostModel currentPost = allPosts[index];

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  currentPost.fromImageUrl),
                                              radius: 16,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              currentPost.fromName,
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: 3,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(2),
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              width: 3,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(2),
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              width: 3,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(2),
                                                  color: Colors.black),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 480,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                            NetworkImage(currentPost.postUrl),
                                            fit: BoxFit.cover)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 3,
                                        right: 15,
                                        left: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              child: widget.profileViewModel.isLiked == false
                                                  ? const Icon(
                                                CupertinoIcons.heart,
                                                size: 28,
                                              ) :  Icon(
                                                CupertinoIcons.heart_fill,
                                                size: 28,
                                                color: ConstantColor.appColor,
                                              ),
                                              onTap: () async {
                                                widget.profileViewModel.isLiked = !widget.profileViewModel.isLiked;

                                                if (widget.profileViewModel.isLiked == true) {
                                                  await widget.profileViewModel
                                                      .increasePostLike(
                                                      currentPost.postId!,
                                                      currentPost.fromId);
                                                } else {
                                                  await widget.profileViewModel
                                                      .decreasePostLike(
                                                      currentPost.postId!,
                                                      currentPost.fromId);
                                                }


                                              },
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Icon(
                                              CupertinoIcons.bubble_left,
                                              size: 25,
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
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 0, left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          currentPost.likes.toString() +
                                              ' likes', style: GoogleFonts.lato(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3,
                                        bottom: 20,
                                        left: 15,
                                        right: 15),
                                    child: Row(
                                      children: [
                                        Text(currentPost.fromName,
                                            style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(currentPost.description ?? '',
                                            style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
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
                ))
          ],
        ),
      ),
    );
  }
}
