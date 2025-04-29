import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/events.dart';
import 'package:flutter_application_3/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart' as auth;

Future<List<model.User>> fetchAllUsersFromFirestore() async {
  final snapshot = await auth.FirebaseFirestore.instance.collection('users').get();
  return snapshot.docs.map((doc) {
    return model.User.fromFirestore(doc.data(), doc.id);
  }).toList();
}
class AppBarSearchResults {
  final String name;           // Username or event title
  final String objectType;     // "User" or "Event"
  final Image image;           // Profile picture or event image
  final String description;    // Bio or event description
  final String id;             // Firebase UID or eventId.toString()

  AppBarSearchResults(
    this.name,
    this.objectType,
    this.image,
    this.description,
    this.id,
  );
}

class PersistentAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PersistentAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<PersistentAppBar> createState() => _PersistentAppBarState();
}

class _PersistentAppBarState extends State<PersistentAppBar> {
  final TextEditingController _controller = TextEditingController();
  List<AppBarSearchResults> _allResults = [];
  List<AppBarSearchResults> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    _compileSearchResults();
  }

  Future<void> _compileSearchResults() async {
    final List<AppBarSearchResults> results = [];

    // Add all events to search results
    for (final event in getEventsList()) {
      results.add(AppBarSearchResults(
        event.title,
        "Event",
        event.eventImage,
        event.description,
        event.eventId.toString(),
      ));
    }

    // Fetch all users from Firestore
    final users = await fetchAllUsersFromFirestore();

    for (final user in users) {
      results.add(AppBarSearchResults(
        user.username,
        "User",
        Image.network(user.profileImageUrl ?? 'https://example.com/default-avatar.png'),
        user.bio ?? 'No bio available',
        user.uid, 
      ));
    }

    setState(() {
      _allResults = results;
      _filteredResults = results;
    });
  }

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredResults = _allResults
          .where((r) => r.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search users or events...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
          if (_controller.text.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              color: Colors.white,
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredResults.length,
                itemBuilder: (context, index) {
                  final result = _filteredResults[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: result.image.image,
                    ),
                    title: Text(result.name),
                    subtitle: Text(result.objectType),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Tapped ${result.objectType}: ${result.name}",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
