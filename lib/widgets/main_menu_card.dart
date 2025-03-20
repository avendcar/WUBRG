import 'package:flutter/material.dart';

class MainMenuCard extends StatelessWidget {
  const MainMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttons,
  });
  final String title;
  final String subtitle;
  final int buttons;

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
                title: Text(title,
                    style: TextStyle(fontFamily: "Belwe", fontSize: 32),
                    textAlign: TextAlign.start),
                subtitle: SizedBox(
                  width: 25,
                  height: MediaQuery.of(context).size.height * 0.3,
                  //Size of box containing all buttons
                  child: SingleChildScrollView(
                    //Allows for scrolling within each card if there exist more than 2 buttons
                    child: Column(
                      children: [
                        for (int x = 1; x < buttons + 1; x++)
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 100,
                                child: IntrinsicHeight(
                                  child: OutlinedButton.icon(
                                    style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        child: Image.asset(
                                            "images/kuriboh.png"), //Image representing the event/user
                                      ),
                                    ),
                                    label: Text(
                                      "$subtitle (Button #$x)",
                                      maxLines:
                                          4, //Amount of lines before text is cut off and the end is replaced with ellipsis
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "Belwe",
                                          color: Colors.black),
                                    ),
                                    iconAlignment: IconAlignment.start,
                                    onPressed: () {
                                      //Generic cards do not lead anywhere by default
                                    },
                                  ),
                                ),
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
