import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/find_players_page.dart';

import '../widgets/app_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/text_card.dart';
import 'personal_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(
      {super.key,
      required this.username,
      required this.profilePicture,
      required this.bio});
  final String username;
  final Image profilePicture;
  final String bio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150, left: 150),
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const FindPlayersPage(),
              ),
            );
          },
          child: Text(
            "Go back to the find players page",
            style: TextStyle(
                color: Colors.white, fontFamily: "Belwe", fontSize: 24),
          ),
        ),
      ),
      
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
                        username, //Displays username set in edit_profile_page.dart
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
                              backgroundImage: profilePicture.image,
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
                    TextCard(
                      title: "User Info",
                      textBox: Text(
                        bio,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Belwe",
                            fontSize: 24),
                      ),
                      height: MediaQuery.of(context).size.width * 0.175,
                      width: MediaQuery.of(context).size.width * 0.5,
                      endIndent: 770,
                      color: const Color.fromARGB(255, 23, 100, 163),
                    ),
                    SizedBox(
                      height: 60,
                      //Space between the User Details and Activity profile cards
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
                    ),
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
