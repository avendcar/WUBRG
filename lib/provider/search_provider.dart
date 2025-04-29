import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/objects/events.dart';
import 'package:flutter_application_3/objects/app_bar_search_results.dart';
import 'package:flutter_application_3/models/user.dart' as model;

class SearchProvider with ChangeNotifier {
  final List<AppBarSearchResults> _results = [];

  List<AppBarSearchResults> get results => _results;

  /// Asynchronously compiles search results from Firestore
  Future<void> compile() async {
    _results.clear();

    try {
      // Add static/local events first
      for (final event in eventsList) {
        _results.add(AppBarSearchResults(
          event.title,
          "Event",
          event.eventImage,
          event.description,
          event.eventId.toString(),
        ));
      }

      // Fetch users from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .limit(50) 
          .get();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final modelUser = model.User.fromFirestore(data, doc.id);

        _results.add(AppBarSearchResults(
          modelUser.username,
          "User",
          Image.network(
            modelUser.profileImageUrl ?? 'kuriboh.png',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
          modelUser.bio ?? "No bio available",
          modelUser.uid,
        ));
      }

      notifyListeners();
    } catch (e, stackTrace) {
      debugPrint("🔥 Error in SearchProvider.compile: $e");
      debugPrint(stackTrace.toString());
    }
  }

  void clear() {
    _results.clear();
    notifyListeners();
  }
}
