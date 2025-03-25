import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/detailed_event_page.dart';

class EventTile extends StatelessWidget {
  //Tiles that will be displayed in the main menu representing events. Will soon replace the existing generic buttons(tiles).
  const EventTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 143,
      child: ButtonTheme(
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 5, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailedEventPage(),
              ),
            );
          },
          label: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: ClipOval(
                    child: Image.asset("images/kuriboh.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 250,
                  child: Text(
                    "Title : Event titles are this long.",
                    style: TextStyle(
                        fontFamily: "Belwe", fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    "Location : Here is the event location text, which should be about this long.",
                    style: TextStyle(
                        fontFamily: "Belwe", fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    "Date : The date is this big",
                    style: TextStyle(
                        fontFamily: "Belwe", fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
