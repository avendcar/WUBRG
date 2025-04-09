import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/main_menu_calendar_card.dart';
import 'package:flutter_application_3/widgets/main_menu_card.dart';
import 'package:flutter_application_3/widgets/main_menu_find_players_card.dart';
import 'package:flutter_application_3/widgets/main_menu_events_card.dart';
import 'package:flutter_application_3/widgets/main_menu_friends_card.dart';
import 'package:flutter_application_3/widgets/main_menu_messages_card.dart';
import '../objects/user.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static User signedInUser = User(
    //Test data for the currently signed in user.
    //Hard coded for now, but will be integrated with the database later.
    //TODO: Implement way to store the data of the signed in user according to who signed in
    "Signed in username",
    4,
    "Signed in bio",
    Image.asset("images/sloth.png"),
    [], //User tags
    [], //Events the user has joined
  );

  static List<String> allTags = [
    "Prefers any format",
    "Prefers commander format",
    "Prefers standard format",
    "Casual",
    "Competitive",
    "18+"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/mtg-background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(
                      20.0), //Padding between large container and all the cards
                  child: Row(
                    children: [
                      //Large button height: 250. Small button height: 100.
                      MainMenuCalendarCard(
                        title: "Calendar",
                        subtitle:
                            "Click here to navigate to the calendar page.",
                      ),
                      SizedBox(width: 10),
                      MainMenuFindPlayersCard(
                        title: "Find Players",
                        subtitle:
                            "Click here to navigate to the find players page.",
                      ),
                      SizedBox(width: 10),
                      MainMenuEventsCard(
                          title: "All Events",
                          subtitle: "Click here to go to the events page."),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(
                      20.0), //Padding between large container and all the cards
                  child: Row(
                    children: [
                      MainMenuMessagesCard(
                        title: "Messages",
                        numOfMessages: 4,
                      ),
                      SizedBox(width: 10),
                      MainMenuFriendsCard(
                        title: "Friends",
                        numOfFriends: 5,
                        subtitle: "This is a description in the Friends card",
                      ),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "New Card Sets",
                          buttons: 6,
                          subtitle: "This is a description in New Card Sets"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
