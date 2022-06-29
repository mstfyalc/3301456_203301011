import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/story_model.dart';

class ShowStoriesPage extends StatefulWidget {
  final StoryModel currentStory;

  const ShowStoriesPage({required this.currentStory, Key? key}) : super(key: key);

  @override
  State<ShowStoriesPage> createState() => _ShowStoriesPageState();
}

class _ShowStoriesPageState extends State<ShowStoriesPage> {
  @override
  Widget build(BuildContext context) {
    StoryModel currentStory = widget.currentStory;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    currentStory.storyUrl),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                     CircleAvatar(
                      backgroundImage: NetworkImage(
                          currentStory.fromImageUrl),
                      radius: 21,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      currentStory.fromUserName,
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '3h',
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(CupertinoIcons.arrow_left),color: Colors.white,),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 28,
            ),
          ],
        ),
      ),
    );
  }
}
