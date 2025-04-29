import 'package:flutter/material.dart' hide Table;
import 'package:flutter_application_3/objects/events.dart';
import 'package:flutter_application_3/pages/detailed_event_page.dart';
import 'package:intl/intl.dart';

List<Event> eventList = getEventsList();

class EventTile extends StatefulWidget {
  //Tiles that will be displayed in the main menu representing events. Will soon replace the existing generic buttons(tiles).
  const EventTile({
    super.key,
    required this.eventId,
  });
 final int eventId;

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  
  @override
  Widget build(BuildContext context) {
    Event currentEvent = eventList.firstWhere((event) => event.eventId == widget.eventId);
    final f = DateFormat("yyyy-MM-dd hh:mm a");
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
                builder: (context) => DetailedEventPage(eventId: currentEvent.eventId),
              ),
            );
          },
          label: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: ClipOval(
                    child: currentEvent.eventImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 250,
                  child: Text(
                    currentEvent.title,
                    style: TextStyle(
                        fontFamily: "Belwe", fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    currentEvent.location,
                    style: TextStyle(
                        fontFamily: "Belwe", fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    "Date : ${f.format(currentEvent.dateTime)}",
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
