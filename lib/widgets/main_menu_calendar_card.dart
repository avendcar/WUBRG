import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/calendar_page.dart';

class MainMenuCalendarCard extends StatelessWidget {
  //Check main_page.dart to see how this widget is used
  const MainMenuCalendarCard({
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
                                      child: Icon(Icons
                                          .calendar_month_outlined, size: 128, color: Colors.black,), //Image representing the event/user
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
                                            const CalendarPage(),
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
