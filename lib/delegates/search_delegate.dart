import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/app_bar_search_results.dart';
import 'package:flutter_application_3/pages/detailed_event_page.dart';
import 'package:flutter_application_3/pages/detailed_find_players_page.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter_application_3/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreenProviderDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context, listen: false);
    final filtered = _filter(provider.results, query);
    return _buildResults(context, filtered);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context, listen: false);
    final filtered = _filter(provider.results, query);
    return _buildResults(context, filtered);
  }

  List<AppBarSearchResults> _filter(List<AppBarSearchResults> results, String q) {
    return results.where((r) => r.name.toLowerCase().contains(q.toLowerCase())).toList();
  }

  Widget _buildResults(BuildContext context, List<AppBarSearchResults> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: result.image,
          ),
          title: Text(result.name),
          onTap: () {
            close(context, result.name);
            switch (result.objectType) {
              case "User":
                if (MainPage.signedInUser?.uid == result.id) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PersonalProfilePage()));
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DetailedFindPlayersPage(uid: result.id)));
                }
                break;
              case "Event":
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DetailedEventPage(eventId: int.parse(result.id))));
                break;
            }
          },
        );
      },
    );
  }
}
