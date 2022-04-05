import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/ui/constant/constant_color.dart';
import 'package:mychat/ui/pages/post_list.dart';
import 'package:mychat/viewModel/profile_view_model.dart';

import '../../../../model/post_model.dart';

class Stories extends StatefulWidget {
  final ProfileViewModel profileViewModel;

  const Stories({required this.profileViewModel, Key? key}) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.profileViewModel
          .getPostsByUserId(widget.profileViewModel.currentUser!.userId),
      builder:
          (BuildContext context, AsyncSnapshot<List<PostModel>> snapShots) {
        if (snapShots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapShots.connectionState == ConnectionState.active ||
            snapShots.connectionState == ConnectionState.done) {
          if (snapShots.hasError) {
            return const Text('Error');
          } else if (!snapShots.hasData) {
            return const Center(
              child: Text('No talks'),
            );
          } else if (snapShots.hasData) {
            List<PostModel> allPosts = snapShots.data!;
            return allPosts.isNotEmpty
                ? GridView.builder(
                itemCount: allPosts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0
                ),
                itemBuilder: (context,index) {
                  PostModel currentPost = allPosts[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostList(profileViewModel: widget.profileViewModel)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(currentPost.postUrl),fit: BoxFit.cover)
                      ),
                    ),
                  );
                } )
                : isPostsEmpty();
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
    );
  }

  Widget isPostsEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  CupertinoIcons.camera,
                  size: 35,
                ),
              ),
            ),
            Text(
              'No Posts Yet',
              style: GoogleFonts.lato(fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
              child: Text(
                'When you share photos,they\'ll appear on your profile',
                style: GoogleFonts.lato(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 50, right: 50, bottom: 5),
              child: TextButton(
                child: Text('Share your first photo',
                    style: GoogleFonts.lato(
                        fontSize: 15, color: ConstantColor.appColor)),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
