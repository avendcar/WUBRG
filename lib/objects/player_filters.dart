import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/models/user.dart' as model;

//  Player search input (e.g., from a search bar)
String playerSearchFilter = "";

//  Default: All tags are selected
List<String> selectedTagFilter = MainPage.allTags;

///  Converts tags to displayable string
String generateTagOutput(List<String> tags) {
  if (tags.isEmpty) return "None";
  return '${tags.join(', ')}.';
}

///  Adds or removes a tag from the selected filters
void updateTagFilter(String inputTag) {
  if (!selectedTagFilter.contains(inputTag)) {
    selectedTagFilter.add(inputTag);
  } else {
    selectedTagFilter.remove(inputTag);
  }
}

///  Client-side filter by partial username match
List<model.User> filterBySearch(List<model.User> unfilteredPlayers, String desiredPlayerName) {
  if (desiredPlayerName.isEmpty) return unfilteredPlayers;

  return unfilteredPlayers
      .where((player) => player.username.toLowerCase().contains(desiredPlayerName.toLowerCase()))
      .toList();
}

///  Client-side filter: user has any matching tag
List<model.User> filterByTags(List<model.User> unfilteredPlayers, List<String> desiredTags) {
  if (desiredTags.isEmpty) return unfilteredPlayers;

  return unfilteredPlayers.where((player) {
    return player.tags.any((tag) => desiredTags.contains(tag));
  }).toList();
}

///  Main fetch function: loads all users, filters out self, applies tag + name filters
Future<List<model.User>> fetchFilteredUsers() async {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  // Fetch all users
  final snapshot = await FirebaseFirestore.instance.collection('users').get();

  // Convert Firestore docs to model.User list, excluding current user
  final allUsers = snapshot.docs
      .map((doc) => model.User.fromFirestore(doc.data(), doc.id))
      .where((user) => user.uid != currentUserId)
      .toList();

  // Apply filters
  final filteredByName = filterBySearch(allUsers, playerSearchFilter);
  final filteredByTags = filterByTags(filteredByName, selectedTagFilter);

  return filteredByTags;
}
