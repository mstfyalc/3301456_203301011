import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/viewModel/profile_view_model.dart';

import '../../model/post_model.dart';
import '../widgets/common_widgets/post_detail_widget.dart';

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

                              return  PostDetailWidget(currentPost: currentPost,currentUser: widget.profileViewModel.currentUser!,);
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
