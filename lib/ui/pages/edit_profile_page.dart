import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mychat/viewModel/profile_view_model.dart';
import '../../model/new_user_model.dart';
import '../constant/constant_color.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileViewModel profileViewModel;

  const EditProfilePage({required this.profileViewModel, Key? key})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  late TextEditingController _descriptionController;
  late ImagePicker _picker;

  @override
  void initState() {
    _picker = ImagePicker();
    _nameController = TextEditingController();
    _userNameController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  File? profilePhoto;

  @override
  Widget build(BuildContext context) {
    final _profileViewModel = widget.profileViewModel;

    if (_profileViewModel.currentState == ProfileViewState.busy) {
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
                        'Edit Profile',
                        style: GoogleFonts.lato(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.checkmark_alt,
                            size: 35,
                            color: ConstantColor.appColor,
                          )),
                    ],
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: ConstantColor.appColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else if (_profileViewModel.currentState == ProfileViewState.idle) {
      NewUserModel? _currentUser = _profileViewModel.currentUser;


      _userNameController.text = _currentUser!.userName!;
      _nameController.text = _currentUser.name!;
      _descriptionController.text = _currentUser.description ?? '';

      void _photoFromCamera() async {
        XFile? _profileImage =
            await _picker.pickImage(source: ImageSource.camera);
        if (_profileImage != null) {
          setState(() {
            profilePhoto = File(_profileImage.path);
          });

        }
      }

      void _photoFromGallery() async {
        XFile? _profileImage =
            await _picker.pickImage(source: ImageSource.gallery);
        if (_profileImage != null) {
          setState(() {
            profilePhoto = File(_profileImage.path);
          });
        }
      }


      void _savePhoto(BuildContext context) async {
        if (profilePhoto != null) {
          String? profileUrl = await _profileViewModel.getProfilePhoto(_currentUser.userId, 'profile_photo', profilePhoto!);
          await _profileViewModel.uploadProfilePhoto(profileUrl!,_currentUser.userId);
        } else {
          debugPrint('Seçilmedi');
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
                        'Edit Profile',
                        style: GoogleFonts.lato(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            _currentUser.name = _nameController.text;
                            _currentUser.userName = _userNameController.text;
                            _currentUser.description =
                                _descriptionController.text;
                            _savePhoto(context);
                            _profileViewModel.updateUser(_currentUser);
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
                  Stack(
                    children: [
                      Positioned(
                        child: Hero(
                          tag: _currentUser.userId,
                          child: CircleAvatar(
                            backgroundImage:
                                profilePhoto == null ?
                                NetworkImage(_currentUser.profileImageUrl!) : (FileImage(profilePhoto!) as ImageProvider),
                            radius: 65,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                              onPressed: () => showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(26),
                                          topRight: Radius.circular(26))),
                                  context: context,
                                  builder: (context) => Container(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 2,
                                            left: 5,
                                            right: 5),
                                        height: 191,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 38,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xffadb5bd)),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text('Change profile photo',style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w400),),
                                            const SizedBox(height: 5,),
                                            const Divider(),
                                            ListTile(
                                              leading: const Icon(
                                                  CupertinoIcons.camera),
                                              title:  Text(
                                                  'Take from camera',style: GoogleFonts.lato(),),
                                              onTap: ()  {
                                                _photoFromCamera();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                                leading: const Icon(
                                                    CupertinoIcons.photo),
                                                title:  Text(
                                                    'Select from gallery',style: GoogleFonts.lato()),
                                                onTap: ()   {
                                                  _photoFromGallery();
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        ),
                                      )),
                              icon: const Icon(
                                CupertinoIcons.camera_fill,
                                color: Colors.white,
                                size: 25,
                              )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xffc1c8c7)),
                        ),
                      )
                    ],
                  ),
                  Form(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: TextFormField(
                            initialValue: _currentUser.email,
                            readOnly: true,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: TextFormField(
                            controller: _userNameController,
                            decoration: const InputDecoration(
                              label: Text('UserName'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              label: Text('Name'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              label: Text('Description'),
                            ),
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
    } else {
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
                      'Edit Profile',
                      style: GoogleFonts.lato(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
                const Center(
                  child: Text('Something go wrong'),
                )
              ],
            ),
          ),
        ),
      ));
    }
  }
}
