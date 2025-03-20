import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/main_menu_card.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
                  color: const Color.fromARGB(255, 13, 56, 92),
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
                      MainMenuCard(
                          title: "Calendar",
                          //TODO: Have this button lead to the calendar page
                          buttons: 1,
                          buttonHeight: 250,
                          subtitle:
                              "This is a description in the Calendar menu card"),

                      SizedBox(width: 10),
                      MainMenuCard(
                        title: "For You",
                        buttons: 3,
                        buttonHeight: 100,
                        subtitle: "This is a description in For You card",
                      ),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "All Events",
                          //TODO: Have this button lead to the events page
                          buttons: 1,
                          buttonHeight: 250,
                          subtitle:
                              "This is a description in the All Events menu card"),
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
                  color: const Color.fromARGB(255, 13, 56, 92),
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
                      MainMenuCard(
                          title: "Message Recipient",
                          buttons: 4,
                          buttonHeight: 100,
                          subtitle:
                              "This is a description in the Messages card"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "Friends",
                          buttons: 5,
                          buttonHeight: 100,
                          subtitle:
                              "This is a description in the Friends card"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "New Card Sets",
                          buttons: 6,
                          buttonHeight: 100,
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
