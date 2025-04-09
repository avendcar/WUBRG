import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/edit_profile_page.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/edit_profile_button.dart';
import 'package:flutter_application_3/widgets/text_card.dart';
import 'package:flutter_application_3/widgets/user_info_card.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: EditProfileButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.only(
            top: deviceHeight(context) * 0.095,
            bottom: deviceHeight(context) * 0.095,
            left: deviceWidth(context) * .095,
            right: deviceWidth(context) * .095),
        //Distance of profile box from the edges of the body
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.black],
          ),
        ),
        child: Container(
          //Grey box
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: const Color.fromARGB(255, 23, 100, 163), width: 10),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        MainPage.signedInUser
                            .username, //Displays username set in edit_profile_page.dart
                        style: TextStyle(
                            fontFamily: "Belwe",
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 45),
                          child: Center(
                            child: CircleAvatar(
                              radius: 175,
                              backgroundImage: pickedFile == null
                                  ? MainPage.signedInUser.profilePicture
                                      .image //Default profile icon if picked file is null
                                  : FileImage(
                                      //Custom profile icon if picked file is not null
                                      File(pickedFile!.path!),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextCard(
                        title: "Decks",
                        textBox: Text(
                          "This is filler text",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Belwe",
                              fontSize: 18),
                        ),
                        height: MediaQuery.of(context).size.width * 0.165,
                        width: MediaQuery.of(context).size.width * 0.2,
                        endIndent: 270,
                        color: const Color.fromARGB(255, 23, 100, 163),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 120),
                Column(
                  children: [
                    UserInfoCard(
                      title: "User Info",
                      height: MediaQuery.of(context).size.width * 0.175,
                      width: MediaQuery.of(context).size.width * 0.5,
                      endIndent: 770,
                      color: const Color.fromARGB(255, 23, 100, 163),
                      tags: MainPage.signedInUser.tags,
                      bio: MainPage.signedInUser.bio,
                    ),
                    SizedBox(
                      height: 60,
                      //Space between the user info and friends profile cards
                    ),
                    Expanded(
                      child: TextCard(
                        title: "Friends",
                        textBox: Text(
                          "This is filler text",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Belwe",
                              fontSize: 18),
                        ),
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.5,
                        endIndent: 820,
                        color: const Color.fromARGB(255, 23, 100, 163),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
