// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/calendar_page.dart';
import 'package:flutter_application_3/pages/deck_builder_page.dart';
import 'package:flutter_application_3/pages/events_page.dart';
import 'package:flutter_application_3/pages/home_page.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../pages/personal_profile_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 470,
        child: Opacity(
          opacity: 0.7,
          child: Drawer(
            backgroundColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40), // Top spacing
                  ListTile(
                    title: Center(
                      heightFactor: 1,
                      child: const Text(
                        "Home",
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Belwe"),
                      ),
                    ),
                    tileColor: const Color.fromRGBO(224, 224, 224, 1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Box for the user's profile
                  ListTile(
                      title: Center(
                        heightFactor: 1,
                        child: const Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Belwe"),
                        ),
                      ),
                      tileColor: const Color.fromRGBO(224, 224, 224, 1),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PersonalProfilePage()),
                        );
                      }),
                  SizedBox(height: 16),
                  // Box for the user's decks
                  ListTile(
                    title: Center(
                      heightFactor: 1,
                      child: const Text(
                        "Decks",
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Belwe"),
                      ),
                    ),
                    tileColor: const Color.fromRGBO(224, 224, 224, 1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                     onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DeckBuilderPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Box for calendar
                  ListTile(
                    title: Center(
                      heightFactor: 1,
                      child: const Text(
                        "Calendar",
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Belwe"),
                      ),
                    ),
                    tileColor: const Color.fromRGBO(224, 224, 224, 1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.deepPurple, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Box for favorites
                  ListTile(
                    title: Center(
                      heightFactor: 1,
                      child: const Text(
                        "Events",
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Belwe"),
                      ),
                    ),
                    tileColor: const Color.fromRGBO(224, 224, 224, 1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventsPage()),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Box for signing out
                  ListTile(
  title: Center(
    heightFactor: 1,
    child: const Text(
      "Sign out",
      style: TextStyle(color: Colors.black, fontFamily: "Belwe"),
    ),
  ),
  tileColor: const Color.fromRGBO(224, 224, 224, 1),
  shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.green, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
  onTap: () async {
    await auth.FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  },
),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
