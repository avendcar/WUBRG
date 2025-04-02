import 'package:flutter/material.dart' hide Table;
import 'package:flutter_application_3/objects/table_object.dart';

//All event information will be placed in this file from back end
class Event {
  Event(
      this.dateTime,
      this.title,
      this.location,
      this.description,
      this.eventImage,
      this.totalSeats,
      this.tables,
      this.tableList,
      this.format);
  DateTime dateTime;
  String title;
  String location;
  String description;
  Image eventImage;
  int totalSeats;
  int takenSeats = 0;
  int tables;
  List<TableObject> tableList;
  String format;
}

//Hard coded events used for testing purposes. Will be deleted after API integration.
List<Event> eventsList = [event1, event2, event3, event4];

Event event1 = (Event(
    DateTime.utc(2025, 11, 11, 11, 11),
    "Battle City",
    "123 Street St., El Paso, TX 79835",
    "Become the king of games!",
    Image.asset("images/kuriboh.png"),
    100, //Total seats at the event
    20, //Number of tables at the event
    generateTableList(20, 5),
    "Commander"));
Event event2 = (Event(
    DateTime.utc(2025, 12, 12, 12, 12),
    "Clash of Cards",
    "456 Avenue, El Paso, TX 79835",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    Image.asset("images/sloth.png"),
    32,
    5,
    generateTableList(5, 2),
    "Standard"));
Event event3 = (Event(
    DateTime.utc(2025, 3, 25, 13, 13),
    "Event Title 3",
    "Event Location 3",
    "Event Description 3",
    Image.asset("images/kuriboh.png"),
    12,
    3,
    generateTableList(5, 5),
    "Commander"));
Event event4 = (Event(
    DateTime.utc(2025, 6, 14, 14, 14),
    "Event Title 4",
    "Event Location 4",
    "Event Description 4",
    Image.asset("images/sloth.png"),
    12,
    6,
    generateTableList(6, 2),
    "Standard"));

//Outputs the event list created in this dart file to be used by outside dart files
List<Event> getEventsList() {
  return eventsList;
}
