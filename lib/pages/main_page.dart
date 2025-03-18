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
            //TODO: populate containers with smaller boxes and data
            SizedBox(height: 50),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
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
                          subtitle:
                              "This is the subtitle for the Upcoming menu card"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "Popular",
                          subtitle:
                              "This is the subtitle for the Popular menu card"),
                      SizedBox(width: 10),
                      MainMenuCard(
                          title: "For You",
                          subtitle:
                              "This is the subtitle for the For You card"),
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
              child: Opacity(
                opacity: 0.5,
                child: Container(
                    color: Colors.green,
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.8),
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
