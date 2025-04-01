import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/events.dart';

class User {
  //TODO Optional: Implement empty deck list by default to each user
  User(this.username, this.userId, this.bio, this.profilePicture);
  String username;
  int userId;
  String bio;
  Image profilePicture;
  List<Event> joinedEvents = [];
}


