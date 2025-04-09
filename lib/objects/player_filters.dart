import 'package:flutter_application_3/objects/user.dart';
import 'package:flutter_application_3/pages/main_page.dart';

List<User> filteredList = getUserList();
List<User> userList = getUserList();
List<String> tagCollection = MainPage.allTags;

String playerSearchFilter = "";
List<String> selectedTagFilter = MainPage.allTags;

String generateTagOutput(List<String> tags) {
  String tagOutput = "";
  for (String tag in tags) {
    tagOutput += " $tag,";
  }
  if (tagOutput == "") {
    return "None";
  } else {
    tagOutput = tagOutput.substring(0, tagOutput.length - 1);
    tagOutput += ".";
    return tagOutput;
  }
}

void updateTagFilter(String inputTag) {
  if (!selectedTagFilter.contains(inputTag)) {
    selectedTagFilter.add(inputTag);
  } else {
    selectedTagFilter.remove(inputTag);
  }
}

List<User> filterBySearch(
    List<User> unfilteredPlayers, String desiredPlayerName) {
  List<User> listToBeReturned = [];
  if (desiredPlayerName.isEmpty) {
    return userList;
  }
  for (User player in unfilteredPlayers) {
    if (player.username.toLowerCase().contains(desiredPlayerName)) {
      listToBeReturned.add(player);
    }
  }
  return listToBeReturned;
}

List<User> filterByTags(
    List<User> unfilteredPlayers, List<String> desiredTags) {
  List<User> listToBeReturned = [];
  for (User player in unfilteredPlayers) {
    for (String tag in player.tags) {
      if (desiredTags.contains(tag)) {
        listToBeReturned.add(player);
        break;
      }
    }
  }
  return listToBeReturned;
}
