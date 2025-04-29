// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/objects/player_filters.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'package:flutter_application_3/widgets/player_tile.dart';
import 'package:flutter_application_3/models/user.dart' as model;

class FindPlayersPage extends StatefulWidget {
  const FindPlayersPage({super.key});

  @override
  State<FindPlayersPage> createState() => _FindPlayersPageState();
}

class _FindPlayersPageState extends State<FindPlayersPage> {
  late Future<List<model.User>> _filteredUsersFuture;

  @override
  void initState() {
    super.initState();
    _filteredUsersFuture = fetchFilteredUsers();
  }

  void _applyFilters() {
    setState(() {
      _filteredUsersFuture = fetchFilteredUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.only(
          top: deviceHeight(context) * 0.095,
          bottom: deviceHeight(context) * 0.095,
          left: deviceWidth(context) * .095,
          right: deviceWidth(context) * .095,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.orange, Colors.black],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orangeAccent, width: 10),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              children: [
                // 🔹 FILTER PANEL
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.orangeAccent,
                          width: 10,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text("Player Filters", style: TextStyle(color: Colors.white, fontFamily: "Belwe", fontSize: 24)),
                          const Divider(indent: 10, endIndent: 10),
                          const Text("User name", style: TextStyle(fontFamily: "Belwe", fontSize: 16, color: Colors.white)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  hintText: "Search by user name",
                                ),
                                onChanged: (value) {
                                  playerSearchFilter = value;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _applyFilters,
                            child: const Text("Apply filters"),
                          ),
                          const SizedBox(height: 10),
                          const Text("Filter by user tags", style: TextStyle(color: Colors.white, fontFamily: "Belwe", fontSize: 16)),
                          const Divider(indent: 10, endIndent: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Text("Currently Selected Tags : ", style: TextStyle(color: Colors.white, fontFamily: "Belwe")),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(generateTagOutput(selectedTagFilter), style: const TextStyle(color: Colors.white)),
                                  ),
                                  const SizedBox(height: 20),
                                  for (String tag in [
                                    "18+",
                                    "Competitive",
                                    "Casual",
                                    "Prefers standard format",
                                    "Prefers commander format",
                                    "Prefers any format",
                                  ])
                                    TextButton(
                                      onPressed: () {
                                        updateTagFilter(tag);
                                        setState(() {});
                                      },
                                      child: Text(tag, style: const TextStyle(color: Colors.white)),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const VerticalDivider(),

                // 🔹 PLAYER DISPLAY PANEL
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.orangeAccent,
                          width: 10,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: FutureBuilder<List<model.User>>(
                          future: _filteredUsersFuture,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            final users = snapshot.data!;
                            final currentUid = auth.FirebaseAuth.instance.currentUser!.uid;

                            if (users.isEmpty) {
                              return const Text(
                                "No player exists under the searched name.",
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              );
                            }

                            return SingleChildScrollView(
                              child: Column(
                                children: users.map((user) {
                                  final isSelf = user.uid == currentUid;
                              
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(0, 4),
                                          blurRadius: 12,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Profile tile
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: PlayerTile(uid: user.uid),
                                        ),
                              
                                        // Bio
                                        
                              
                                        // Add Friend button
                                        if (!isSelf)
                                          FutureBuilder<DocumentSnapshot>(
                                            future: FirebaseFirestore.instance.collection('users').doc(currentUid).get(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) return const SizedBox.shrink();
                              
                                              final currentUserData = snapshot.data!.data() as Map<String, dynamic>;
                                              final List currentFriends = currentUserData['friends'] ?? [];
                                              final List sentRequests = currentUserData['sentRequests'] ?? [];
                              
                                              final alreadyFriends = currentFriends.contains(user.uid);
                                              final alreadySent = sentRequests.contains(user.uid);
                              
                                              if (alreadyFriends || alreadySent) return const SizedBox.shrink();
                              
                                              return Container(
                                                constraints: const BoxConstraints(maxWidth: 140),
                                                child: ElevatedButton.icon(
                                                  icon: const Icon(Icons.person_add, size: 18),
                                                  label: const Text("Add Friend", overflow: TextOverflow.ellipsis),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.purple[200],
                                                    foregroundColor: Colors.black,
                                                    elevation: 6,
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                    textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    final batch = FirebaseFirestore.instance.batch();
                                                    final currentUserRef = FirebaseFirestore.instance.collection('users').doc(currentUid);
                                                    final targetUserRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
                              
                                                    batch.update(currentUserRef, {
                                                      'sentRequests': FieldValue.arrayUnion([user.uid])
                                                    });
                              
                                                    batch.update(targetUserRef, {
                                                      'friendRequests': FieldValue.arrayUnion([currentUid])
                                                    });
                              
                                                    await batch.commit();
                              
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text("Friend request sent")),
                                                    );
                              
                                                    setState(() {});
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
