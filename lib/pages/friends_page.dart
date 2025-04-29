// ignore_for_file: use_build_context_synchronously

import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    final currentUser = auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('Not signed in')),
      );
    }

    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight(context) * 0.095,
          horizontal: deviceWidth(context) * 0.095,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.black],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueAccent, width: 4),
          ),
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;
              final List<dynamic> friendUIDs = userData['friends'] ?? [];
              final List<dynamic> pendingUIDs = userData['friendRequests'] ?? [];

              return FutureBuilder<List<DocumentSnapshot>>(
                future: Future.wait(friendUIDs.map(
                    (uid) => FirebaseFirestore.instance.collection('users').doc(uid).get())),
                builder: (context, friendsSnapshot) {
                  if (!friendsSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: [
                      const Text(
                        "Your Friends",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      ...friendsSnapshot.data!.map((friendDoc) {
                        final friendData = friendDoc.data() as Map<String, dynamic>;
                        final friendUID = friendDoc.id;

                        return Card(
                          color: Colors.grey[850],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: friendData['profileImageURL'] != null
                                ? CircleAvatar(backgroundImage: NetworkImage(friendData['profileImageURL']))
                                : const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(friendData['username'] ?? 'Unknown',
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(friendData['email'] ?? '',
                                style: const TextStyle(color: Colors.grey)),
                            trailing: IconButton(
                              icon: const Icon(Icons.person_remove, color: Colors.redAccent),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.uid)
                                    .update({
                                  'friends': FieldValue.arrayRemove([friendUID])
                                });
                              },
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 32),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 8),
                      const Text(
                        "Pending Friend Requests",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      FutureBuilder<List<DocumentSnapshot>>(
                        future: Future.wait(pendingUIDs.map<Future<DocumentSnapshot>>(
                          (uid) => FirebaseFirestore.instance.collection('users').doc(uid).get(),
                        )),
                        builder: (context, pendingSnapshot) {
                          if (!pendingSnapshot.hasData || pendingSnapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("No pending requests", style: TextStyle(color: Colors.grey)),
                            );
                          }

                          return Column(
                            children: pendingSnapshot.data!.map((requestDoc) {
                              final requestData = requestDoc.data() as Map<String, dynamic>;
                              final requestUID = requestDoc.id;

                              return Card(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  leading: requestData['profileImageURL'] != null
                                      ? CircleAvatar(backgroundImage: NetworkImage(requestData['profileImageURL']))
                                      : const CircleAvatar(child: Icon(Icons.person)),
                                  title: Text(requestData['username'] ?? 'Unknown',
                                      style: const TextStyle(color: Colors.white)),
                                  subtitle: Text(requestData['email'] ?? '',
                                      style: const TextStyle(color: Colors.grey)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.check, color: Colors.greenAccent),
                                        onPressed: () async {
                                          final batch = FirebaseFirestore.instance.batch();

                                          final currentUserRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
                                          final requestUserRef = FirebaseFirestore.instance.collection('users').doc(requestUID);

                                          batch.update(currentUserRef, {
                                            'friends': FieldValue.arrayUnion([requestUID]),
                                            'friendRequests': FieldValue.arrayRemove([requestUID])
                                          });

                                          batch.update(requestUserRef, {
                                            'friends': FieldValue.arrayUnion([currentUser.uid]),
                                            'sentRequests': FieldValue.arrayRemove([currentUser.uid])
                                          });

                                          await batch.commit();
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close, color: Colors.redAccent),
                                        onPressed: () async {
                                          final batch = FirebaseFirestore.instance.batch();

                                          final currentUserRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
                                          final requestUserRef = FirebaseFirestore.instance.collection('users').doc(requestUID);

                                          batch.update(currentUserRef, {
                                            'friendRequests': FieldValue.arrayRemove([requestUID])
                                          });

                                          batch.update(requestUserRef, {
                                            'sentRequests': FieldValue.arrayRemove([currentUser.uid])
                                          });

                                          await batch.commit();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => _showAddFriendDialog(context),
        child: const Icon(Icons.person_add),
      ),
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final currentUser = auth.FirebaseAuth.instance.currentUser;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Send Friend Request", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: emailController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter user's email",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () async {
              final email = emailController.text.trim();
              final userQuery = await FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: email)
                  .get();

              if (userQuery.docs.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User not found")));
                return;
              }

              final targetUID = userQuery.docs.first.id;

              if (currentUser != null && targetUID != currentUser.uid) {
                final batch = FirebaseFirestore.instance.batch();

                final currentUserRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
                batch.update(currentUserRef, {
                  'sentRequests': FieldValue.arrayUnion([targetUID])
                });

                final targetUserRef = FirebaseFirestore.instance.collection('users').doc(targetUID);
                batch.update(targetUserRef, {
                  'friendRequests': FieldValue.arrayUnion([currentUser.uid])
                });

                await batch.commit();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Friend request sent")),
                );
              }
            },
            child: const Text("Send", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
