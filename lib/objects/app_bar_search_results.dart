import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/events.dart';
import 'package:flutter_application_3/objects/user.dart';

class AppBarSearchResults {
  AppBarSearchResults(
      this.name, this.objectType, this.image, this.description, this.id);
  String name;
  String objectType; //Is either "Event" or "User"
  Image image;
  String description;
  int id;
}

List<Event> eventList = getEventsList();

List<User> userList = getUserList();

List<Object> combinedList = List.from(eventList)..addAll(userList);

List<AppBarSearchResults> searchResults = [];

void compileSearchResults() {
  searchResults = [];
  for (Object object in combinedList) {
    addEventOrUserToList(object);
  }
}

void addEventOrUserToList(var object) {
  if (object is User) {
    searchResults.add(AppBarSearchResults(object.username, "User",
        object.profilePicture, object.bio, object.userId));
  }
  if (object is Event) {
    searchResults.add(AppBarSearchResults(object.title, "Event",
        object.eventImage, object.description, object.eventId));
  }
}

List<AppBarSearchResults> getSearchResults() {
  return searchResults;
}
