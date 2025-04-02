import 'package:flutter/material.dart' hide Table;
import 'package:flutter_application_3/objects/table_object.dart';
import 'package:flutter_application_3/pages/detailed_event_page.dart';
import 'package:intl/intl.dart';

class EventTile extends StatefulWidget {
  //Tiles that will be displayed in the main menu representing events. Will soon replace the existing generic buttons(tiles).
  const EventTile({
    super.key,
    required this.title,
    required this.dateTime,
    required this.description,
    required this.location,
    required this.eventImage,
    required this.takenSeats,
    required this.totalSeats,
    required this.format,
    required this.tables,
    required this.tableList,
  });
  final String title;
  final DateTime dateTime;
  final String description;
  final String location;
  final Image eventImage;
  final int takenSeats;
  final int totalSeats;
  final int tables;
  final List<TableObject> tableList;
  final String format;

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
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
                builder: (context) => DetailedEventPage(
                  title: widget.title,
                  description: widget.description,
                  dateTime: widget.dateTime,
                  location: widget.location,
                  eventImage: widget.eventImage,
                  totalSeats: widget.totalSeats,
                  takenSeats: widget.takenSeats,
                  tables: widget.tables,
                  tableList: widget.tableList,
                  format: widget.format,
                ),
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
                    child: widget.eventImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 250,
                  child: Text(
                    widget.title,
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
                    widget.location,
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
                    "Date : ${f.format(widget.dateTime)}",
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
