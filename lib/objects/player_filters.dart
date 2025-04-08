import 'package:flutter_application_3/objects/user.dart';

List<User> filteredList = getUserList();
List<User> userList = getUserList();
List<String> tagCollection = compileUserTags();
List<bool> selections = List.generate(tagCollection.length, (_) => true);
//Selections bool list is used to determine if a tag in a tag collection is selected.
//Every value is false by default to indicate none of the tags are selected.

String playerSearchFilter = "";
List<String> selectedTagFilter = [];

List<User> filterBySearch(
    List<User> unfilteredPlayers, String desiredPlayerName) {
  List<User> listToBeReturned = [];
  if (desiredPlayerName.isEmpty) {
    return filteredList;
  }
  for (User player in unfilteredPlayers) {
    if (player.username.toLowerCase().contains(desiredPlayerName)) {
      listToBeReturned.add(player);
    }
  }
  return listToBeReturned;
}
