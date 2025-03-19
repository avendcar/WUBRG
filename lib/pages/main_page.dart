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
            //TODO: populate containers with data
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
                      MainMenuCard(
                          title: "Upcoming",
                          buttons: 1,
                          subtitle:
                              "This is a description in the Upcoming menu card"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "Popular",
                          buttons: 2,
                          subtitle:
                              "This is a description in the Popular menu card"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "For You",
                          buttons: 3,
                          subtitle:
                              "This is a description in For You card",),
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
                          title: "Messages",
                          buttons: 4,
                          subtitle: "This is a description in the Messages card"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "Example Card 2",
                          buttons: 5,
                          subtitle: "This is a description in Example Card 2"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "Example Card 3",
                          buttons: 6,
                          subtitle: "This is a description in Example Card 3"),
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
