import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/new_user_model.dart';

import '../../../../viewModel/profile_view_model.dart';
import '../../../pages/edit_profile_page.dart';

class HeadProfile extends StatelessWidget {
  final NewUserModel currentUser;
  final ProfileViewModel profileViewModel;

  const HeadProfile({required this.profileViewModel,required this.currentUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Hero(
              tag: currentUser.userId,
              child: CircleAvatar(
                backgroundImage: NetworkImage(currentUser.profileImageUrl!),
                radius: 50,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            getInfo('127', 'Post'),
            const SizedBox(
              width: 5,
            ),
            getInfo('2,5M', 'Followers'),
            const SizedBox(
              width: 5,
            ),
            getInfo('150', 'Follow'),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: Text(
            currentUser.name!,
            style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 15),
          child: Text(
            currentUser.description ?? '',
            style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) =>  EditProfilePage(profileViewModel: profileViewModel,)));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            width: 1, color: const Color(0xffdee2e6))),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border:
                          Border.all(width: 1, color: const Color(0xffdee2e6))),
                  child: const Icon(CupertinoIcons.person_add),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column getInfo(String count, String description) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(description,
            style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 15))
      ],
    );
  }


}
