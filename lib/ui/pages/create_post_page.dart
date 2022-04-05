import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychat/viewModel/profile_view_model.dart';


import '../../model/new_user_model.dart';
import '../../model/post_model.dart';
import '../constant/constant_color.dart';

class CreatePostPage extends StatefulWidget {
  final ProfileViewModel profileViewModel;
  const CreatePostPage({required this.profileViewModel,Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  String placeHolder =
      'https://cdn.pixabay.com/photo/2018/11/13/21/43/instagram-3814050_1280.png';

  String? postUrl;
  late TextEditingController _descriptionController;
  late ImagePicker _picker;

  @override
  void initState() {
    _picker = ImagePicker();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  File? profilePhoto;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel _profileViewModel = widget.profileViewModel;
    NewUserModel? _currentUser = _profileViewModel.currentUser;


    Future<bool> _postFromCamera() async {
      XFile? _profileImage =
          await _picker.pickImage(source: ImageSource.camera);
      if (_profileImage != null) {
        setState(() {
          profilePhoto = File(_profileImage.path);
        });
        return true;
      }
      return false;
    }

    Future<bool> _postFromGallery() async {
      XFile? _profileImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (_profileImage != null) {
        setState(() {
          profilePhoto = File(_profileImage.path);
        });
        return true;
      }
      return false;
    }

    Future<String?> getPostUrl() async {
      if (profilePhoto != null) {
        return await _profileViewModel.getPostUrl(
            _currentUser!.userId, 'posts', profilePhoto!);
      } else {
        debugPrint('Seçilmedi');
      }
      return null;
    }


    Future<bool> savePost()async {
      String? postUrl = await getPostUrl();
      if(postUrl == null){
        debugPrint('İşlem başarısız');
        return false;
      }else{
        PostModel postToSave = PostModel(
            fromId: _currentUser!.userId,
            postUrl: postUrl,
            fromName: _currentUser.userName!,
            fromImageUrl: _currentUser.profileImageUrl!,
            description: _descriptionController.text
        );
        bool result = await _profileViewModel.savePost(postToSave);
        return result;
      }

    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
                      'Create Post',
                      style: GoogleFonts.lato(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {
                          savePost();
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
                  height: 25,
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
                                  top: 10, bottom: 2, left: 5, right: 5),
                              height: 205,
                              child: Column(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0xffadb5bd)),
                                  ),
                                  const ListTile(
                                    title: Text('Change profile photo'),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(CupertinoIcons.camera),
                                    title: const Text('Take from camera'),
                                    onTap: () async {
                                      await _postFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                      leading: const Icon(CupertinoIcons.photo),
                                      title: const Text('Select from gallery'),
                                      onTap: ()  async {
                                        await _postFromGallery();
                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 300,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: showPost(profilePhoto) )),
                  ),
                ),
                Form(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              label: Text('Description'),
                              hintText: 'Post description...'),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }


  ImageProvider showPost(File? profilePhoto){
    if(profilePhoto == null){
      return NetworkImage(placeHolder);
    }else{
      return (FileImage(profilePhoto) as ImageProvider);
    }
  }



}
