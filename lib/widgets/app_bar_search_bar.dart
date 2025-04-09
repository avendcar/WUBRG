import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/app_bar_search_results.dart';
import 'package:flutter_application_3/pages/detailed_event_page.dart';
import 'package:flutter_application_3/pages/detailed_find_players_page.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';

class AppBarSearchBar extends StatefulWidget {
  const AppBarSearchBar({super.key});
  @override
  State<AppBarSearchBar> createState() => _AppBarSearchBarState();
}

class CustomSearchDelegate extends SearchDelegate {
  List<AppBarSearchResults> searchTerms = getSearchResults().toSet().toList();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<AppBarSearchResults> matchQuery = [];
    for (AppBarSearchResults result in searchTerms) {
      if (result.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(result);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
          onTap: () {
            query = matchQuery[index].name;
            close(context, query);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<AppBarSearchResults> matchQuery = [];
    for (var result in searchTerms) {
      if (result.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(result);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Container(
          color: Colors.white, //Color of each element in suggestions
          child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(10), child: result.image),
            title: Text(result.name),
            onTap: () {
              query = matchQuery[index].name;
              close(context, query);
              switch (matchQuery[index].objectType) {
                case "User":
                  if (matchQuery[index].id == MainPage.signedInUser.userId) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalProfilePage(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedFindPlayersPage(
                          userId: matchQuery[index].id,
                        ),
                      ),
                    );
                  }
                case "Event":
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedEventPage(
                        eventId: matchQuery[index].id,
                      ),
                    ),
                  );
              }
            },
          ),
        );
      },
    );
  }
}

class _AppBarSearchBarState extends State<AppBarSearchBar> {
  @override
  Widget build(BuildContext context) {
    compileSearchResults();
    return SizedBox(
      width: 300,
      height: 35,
      child: TextButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          );
        },
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(width: 10),
            Text(
              "Search for users and events...",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Belwe", fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
