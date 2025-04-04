import 'package:flutter_application_3/objects/user.dart';

List<User> filteredList = getUserList();

String playerSearchFilter = "";

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
