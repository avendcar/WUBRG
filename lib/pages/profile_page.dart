import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/edit_profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/edit_profile_button.dart';
import 'package:flutter_application_3/widgets/profile_page_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: EditProfileButton(),
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
                    Text(
                      "Username",
                      style: TextStyle(
                          fontFamily: "Belwe",
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                        child: ClipPath(
                          //Hexagonal shaped PFP
                          clipper: Hexagon(),
                          child: Container(
                            color: Colors.grey,
                            child: Image.asset(
                              //Image for PFP
                              'images/mtg-background.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ProfilePageCard(
                        title: "Decks",
                        height: MediaQuery.of(context).size.width * 0.165,
                        width: MediaQuery.of(context).size.width * 0.2,
                        endIndent: 405,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 120),
                Column(
                  children: [
                    ProfilePageCard(
                      title: "User Details",
                      height: MediaQuery.of(context).size.width * 0.175,
                      width: MediaQuery.of(context).size.width * 0.5,
                      endIndent: 1100,
                    ),
                    SizedBox(
                      height: 60,
                      //Space between the User Details and Activity profile cards
                    ),
                    Expanded(
                      child: ProfilePageCard(
                        title: "Activity",
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.5,
                        endIndent: 1150,
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

class Hexagon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Define the hexagon shape using relative positions.
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.75, size.height * sqrt(3) / 2);
    path.lineTo(size.width * 0.25, size.height * sqrt(3) / 2);
    path.lineTo(0, size.height * sqrt(3) / 4);
    path.close(); // Call the close method to complete the path.
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
