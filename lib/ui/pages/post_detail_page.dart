import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/ui/widgets/common_widgets/post_detail_widget.dart';
import 'package:mychat/viewModel/post_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/post_model.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel currentPost;
  final PostViewModel postViewModel;
  const PostDetailPage({required this.postViewModel,required this.currentPost,Key? key}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {

  @override
  Widget build(BuildContext context) {

    final _profileViewModel = widget.postViewModel;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 5,),
                IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black,
                      size: 23,
                    )
                ),
                const SizedBox(width: 20,),
                Text('Explore',style: GoogleFonts.lato(fontSize: 21,color: Colors.black),)
              ],
            ),
            PostDetailWidget(currentPost: widget.currentPost,currentUser: _profileViewModel.currentUser!,)
          ],
        ),
      )
    );
  }
}
