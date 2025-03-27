import 'package:flutter/material.dart';

import 'package:flutter_application_3/pages/find_players_page.dart';

class MainMenuFindPlayersCard extends StatelessWidget {
  const MainMenuFindPlayersCard({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          color: Colors.grey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Align(
                  alignment: Alignment.centerLeft,
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
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Belwe",
                          fontSize: 32),
                    ),
                  ),
                ),
                subtitle: SizedBox(
                  width: 25,
                  height: MediaQuery.of(context).size.height * 0.3,
                  //Size of box containing all buttons
                  child: SingleChildScrollView(
                    //Allows for scrolling within each card if there exist more than 2 buttons
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              height: 250,
                              child: IntrinsicHeight(
                                child: OutlinedButton.icon(
                                  style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    side: WidgetStatePropertyAll(
                                      BorderSide(
                                        color: Colors.transparent,
                                        //Removes border from button object
                                      ),
                                    ),
                                  ),
                                  icon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox(
                                        width: 125,
                                        height: 125,
                                        child: Image.asset("images/sloth.png"),
                                      ), //Image representing the event/user
                                    ),
                                  ),
                                  label: Text(
                                    subtitle,
                                    style: TextStyle(
                                        fontFamily: "Belwe",
                                        color: Colors.black,
                                        fontSize: 32),
                                  ),
                                  iconAlignment: IconAlignment.start,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const FindPlayersPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              //Size of each button within the scrollable box
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
