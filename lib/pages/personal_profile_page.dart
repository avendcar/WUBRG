import 'package:flutter/material.dart';
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
    final user = MainPage.signedInUser;

    return Scaffold(
      floatingActionButton: Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: EditProfileButton(setStateCallback: () => setState(() {})),
),

      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      endDrawer: const AppDrawer(),
      appBar: const PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.only(
          top: deviceHeight(context) * 0.080,
          bottom: deviceHeight(context) * 0.080,
          left: deviceWidth(context) * 0.080,
          right: deviceWidth(context) * 0.080,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.black],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 23, 100, 163),
              width: 10,
            ),
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
                        user?.username ?? "Unknown User",
                        style: const TextStyle(
                          fontFamily: "Belwe",
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: CircleAvatar(
                          radius: 175,
                          backgroundImage: NetworkImage(
                            user?.profileImageUrl ??
                                'https://example.com/default-avatar.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextCard(
                        title: "Decks",
                        textBox: const Text(
                          "This is filler text",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Belwe",
                            fontSize: 18,
                          ),
                        ),
                        height: MediaQuery.of(context).size.width * 0.165,
                        width: MediaQuery.of(context).size.width * 0.2,
                        endIndent: 270,
                        color: const Color.fromARGB(255, 23, 100, 163),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 120),
                Column(
                  children: [
                    UserInfoCard(
                      title: "User Info",
                      height: MediaQuery.of(context).size.width * 0.175,
                      width: MediaQuery.of(context).size.width * 0.5,
                      endIndent: 770,
                      color: const Color.fromARGB(255, 23, 100, 163),
                      tags: user?.tags ?? [],
                      bio: user?.bio ?? "No bio provided",
                    ),
                    const SizedBox(height: 60),
                    Expanded(
                      child: TextCard(
                        title: "Friends",
                        textBox: const Text(
                          "This is filler text",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Belwe",
                            fontSize: 18,
                          ),
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
