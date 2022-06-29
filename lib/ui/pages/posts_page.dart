import 'package:flutter/material.dart';
import 'package:mychat/ui/pages/post_detail_page.dart';
import 'package:provider/provider.dart';

import '../../model/post_model.dart';
import '../../viewModel/post_view_model.dart';
import '../constant/constant_style.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostViewModel _postViewModel = Provider.of<PostViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45.0),
        child: AppBar(
          title: Text(
            'Posts',
            style: ConstantStyle.appNames,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xffc1c8c7),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.contacts,
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
      ),
      body: StreamBuilder(
        stream: _postViewModel.getAllPost(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No Posts Yet'),
              );
            } else if (snapshot.hasData) {
              List<PostModel>? postList = snapshot.data;

              return postList!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GridView.builder(
                          itemCount: postList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 1.5,
                                  mainAxisSpacing: 1.5),
                          itemBuilder: (context, index) {
                            PostModel currentPost = postList[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PostDetailPage(
                                          currentPost: currentPost,
                                          postViewModel: _postViewModel,
                                        )));
                              },
                              child: Hero(
                                tag: currentPost.postId!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(currentPost.postUrl),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            );
                          }),
                    )
                  : const Center(
                      child: Text('data yok'),
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
      ),
    );
  }
}
