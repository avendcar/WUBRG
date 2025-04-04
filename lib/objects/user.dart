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

List<User> getUserList() {
  return userList;
}

List<User> userList = [user1, user2, user3];

User user1 = (User(
  "User 1",
  1,
  "User 1's bio will be roughly this long. This series of sentences was typed for testing purposes.",
  Image.asset("images/kuriboh.png"),
));
User user2 = (User(
  "User 2",
  2,
  "User 2's bio will be roughly this long. This series of sentences was typed for testing purposes.",
  Image.asset("images/sloth.png"),
));
User user3 = (User(
  "User 3",
  3,
  "User 3's bio will be roughly this long. This series of sentences was typed for testing purposes. By this sentence, the sentence should overflow.",
  Image.asset("images/sloth.png"),
));
