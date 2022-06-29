import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychat/model/story_model.dart';

import '../../model/new_user_model.dart';
import '../../viewModel/profile_view_model.dart';
import '../constant/constant_color.dart';

class CreateStoryPage extends StatefulWidget {
  final ProfileViewModel profileViewModel;

  const CreateStoryPage({required this.profileViewModel, Key? key})
      : super(key: key);

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  String? storyUrl;
  late ImagePicker _picker;
  String placeHolder =
      'https://cdn4.vectorstock.com/i/1000x1000/76/08/camera-icon-electronics-symbol-photograph-vector-23497608.jpg';

  @override
  void initState() {
    _picker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  File? storyImage;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel _profileViewModel = widget.profileViewModel;
    NewUserModel? _currentUser = _profileViewModel.currentUser;

    Future<bool> _postFromCamera() async {
      XFile? _storyImage = await _picker.pickImage(source: ImageSource.camera);
      if (_storyImage != null) {
        setState(() {
          storyImage = File(_storyImage.path);
        });
        return true;
      }
      return false;
    }

    Future<bool> _postFromGallery() async {
      XFile? _storyImage = await _picker.pickImage(source: ImageSource.gallery);
      if (_storyImage != null) {
        setState(() {
          storyImage = File(_storyImage.path);
        });
        return true;
      }
      return false;
    }

    Future<String?> getStoryUrl() async {
      if (storyImage != null) {
        return await _profileViewModel.getStoryUrl(
            _currentUser!.userId, 'stories', storyImage!);
      } else {
        debugPrint('Seçilmedi');
      }
      return null;
    }

    Future<bool> saveStory() async {
      String? storyUrl = await getStoryUrl();
      if (storyUrl == null) {
        debugPrint('Something go wrong');
        return false;
      } else {
        NewUserModel currentUser = _currentUser!;
        StoryModel storyToSave = StoryModel(
            fromId: currentUser.userId,
            fromUserName: currentUser.userName!,
            fromImageUrl: currentUser.profileImageUrl!,
            storyUrl: storyUrl);
        bool result = await _profileViewModel.saveStory(storyToSave);
        return result;
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Text(
                          'X',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    Text(
                      'Create Story',
                      style: GoogleFonts.lato(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {
                          saveStory();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          CupertinoIcons.checkmark_alt,
                          size: 35,
                          color: ConstantColor.appColor,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(26),
                                topRight: Radius.circular(26))),
                        context: context,
                        builder: (context) => Container(
                              padding: const EdgeInsets.only(
                                  top: 0, bottom: 2, left: 5, right: 5),
                              height: 190,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 38,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0xffadb5bd)),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text('Select Your Story',style:  GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w400),),
                                  const SizedBox(height: 5,),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(CupertinoIcons.camera),
                                    title:  Text('From camera',style: GoogleFonts.lato(),),
                                    onTap: () async {
                                      await _postFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                      leading: const Icon(CupertinoIcons.photo),
                                      title:  Text('From gallery',style: GoogleFonts.lato()),
                                      onTap: () async {
                                        await _postFromGallery();
                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: showPost(storyImage),fit: BoxFit.contain
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider showPost(File? profilePhoto) {
    if (profilePhoto == null) {
      return AssetImage('assets/images/story-page-place-holder.png');
    } else {
      return (FileImage(profilePhoto) as ImageProvider);
    }
  }
}
