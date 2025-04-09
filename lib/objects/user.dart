import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/events.dart';
import 'package:flutter_application_3/pages/main_page.dart';

class User {
  //TODO: Implement empty deck list by default to each user
  User(this.username, this.userId, this.bio, this.profilePicture, this.tags,
      this.joinedEvents);
  String username;
  int userId;
  String bio;
  Image profilePicture;
  List<String> tags = [];
  List<Event> joinedEvents = [];
}

List<String> compileUserTags() {
//Creates a list of every unique tag from every user.
//Used in the find players page.
  List<String> tagListOutput = [];
  for (User user in userList) {
    for (String tag in user.tags) {
      if (!tagListOutput.contains(tag)) {
        tagListOutput.add(tag);
      }
    }
  }
  return tagListOutput;
}

List<User> getUserList() {
  return userList;
}

List<User> userList = [user1, user2, user3, user4, user5];

User user1 = (User(
    "User 1",
    1,
    "User 1's bio will be roughly this long. This series of sentences was typed for testing purposes.",
    Image.asset(
      "images/kuriboh.png",
    ),
    ["Prefers any format", "Casual", "18+"],
    []));
User user2 = (User(
    "User 2",
    2,
    "User 2's bio will be roughly this long. This series of sentences was typed for testing purposes.",
    Image.asset("images/sloth.png"),
    ["Prefers commander format", "Casual"],
    []));
User user3 = (User(
    "User 3",
    3,
    "User 3's bio will be roughly this long. This series of sentences was typed for testing purposes. By this sentence, the sentence should overflow.",
    Image.asset("images/sloth.png"),
    ["Prefers standard format", "Competitive", "18+"],
    []));
User user4 = (User(
  MainPage.signedInUser.username,
  MainPage.signedInUser.userId,
  MainPage.signedInUser.bio,
  MainPage.signedInUser.profilePicture,
  MainPage.signedInUser.tags,
  MainPage.signedInUser.joinedEvents
));
User user5 = (User(
    "User 5",
    5,
    "User 5's bio will be roughly this long. This series of sentences was typed for testing purposes.",
    Image.asset(
      "images/kuriboh.png",
    ),
    ["Prefers any format", "Casual", "18+"],
    []));
