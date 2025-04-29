import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/models/user.dart' as model;
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/main_menu_calendar_card.dart';
import 'package:flutter_application_3/widgets/main_menu_card.dart';
import 'package:flutter_application_3/widgets/main_menu_find_players_card.dart';
import 'package:flutter_application_3/widgets/main_menu_events_card.dart';
import 'package:flutter_application_3/widgets/main_menu_friends_card.dart';
import 'package:flutter_application_3/widgets/main_menu_messages_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static model.User? signedInUser;

  static List<String> allTags = [
    "Prefers any format",
    "Prefers commander format",
    "Prefers standard format",
    "Casual",
    "Competitive",
    "18+"
  ];

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadSignedInUser();
  }

  Future<void> _loadSignedInUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();
    final data = doc.data();

    if (data != null) {
      setState(() {
        MainPage.signedInUser = model.User.fromFirestore(data, firebaseUser.uid);
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      appBar: const PersistentAppBar(),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/mtg-background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Flexible(
                          child: MainMenuCalendarCard(
                            title: "Calendar",
                            subtitle: "Click here to navigate to the calendar page.",
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: MainMenuFindPlayersCard(
                            title: "Find Players",
                            subtitle: "Click here to navigate to the find players page.",
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: MainMenuEventsCard(
                            title: "All Events",
                            subtitle: "Click here to go to the events page.",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Flexible(
                          child: MainMenuMessagesCard(
                            title: "Messages",
                            numOfMessages: 4,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: MainMenuFriendsCard(
                            title: "Friends",
                            numOfFriends: 5,
                            subtitle: "This is a description in the Friends card",
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: MainMenuCard(
                            title: "New Card Sets",
                            buttons: 6,
                            subtitle: "This is a description in New Card Sets",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
