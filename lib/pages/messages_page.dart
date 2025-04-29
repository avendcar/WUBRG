import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/pages/chat_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  Future<void> _startNewChat(BuildContext context, String currentUserId) async {
    // Fetch user's friends
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();
    final friends = List<String>.from(userDoc['friends'] ?? []);

    if (friends.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have no friends to start a chat with.')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .where(FieldPath.documentId, whereIn: friends)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

            final friendDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: friendDocs.length,
              itemBuilder: (context, index) {
                final friend = friendDocs[index];
                final friendId = friend.id;
                final username = friend['username'] ?? 'Friend';

                return ListTile(
                  title: Text(username),
                  onTap: () async {
                    Navigator.pop(context);

                    // Search for existing chat
                    final chatQuery = await FirebaseFirestore.instance
                        .collection('chats')
                        .where('users', arrayContains: currentUserId)
                        .get();

                    DocumentSnapshot? existingChat;
                    for (var doc in chatQuery.docs) {
                      final users = List<String>.from(doc['users']);
                      if (users.contains(friendId)) {
                        existingChat = doc;
                        break;
                      }
                    }

                    // Create new chat if it doesn't exist
                    DocumentReference chatRef;
                    if (existingChat != null) {
                      chatRef = existingChat.reference;
                    } else {
                      chatRef = await FirebaseFirestore.instance.collection('chats').add({
                        'users': [currentUserId, friendId],
                        'lastMessage': '',
                        'peerUsernames': {
                          currentUserId: userDoc['username'],
                          friendId: friend['username'],
                        },
                      });
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          chatId: chatRef.id,
                          peerId: friendId,
                          peerUsername: friend['username'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.095,
          horizontal: MediaQuery.of(context).size.width * 0.095,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [Colors.green, Colors.black],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 42, 42),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.greenAccent, width: 10),
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .where('users', arrayContains: currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final chatDocs = snapshot.data!.docs;

              if (chatDocs.isEmpty) {
                return Center(
                  child: Text(
                    "No conversations yet.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (context, index) {
                  final chat = chatDocs[index];
                  final chatId = chat.id;
                  final users = List<String>.from(chat['users']);
                  final peerId = users.firstWhere((id) => id != currentUser?.uid);
                  final lastMessage = chat['lastMessage'] ?? '';
                  final peerUsername = chat['peerUsernames']?[peerId] ?? 'User';

                  return ListTile(
                    title: Text(
                      peerUsername,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      lastMessage,
                      style: TextStyle(color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatPage(
                            chatId: chatId,
                            peerId: peerId,
                            peerUsername: peerUsername,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add_comment),
        onPressed: () {
          if (currentUser != null) {
            _startNewChat(context, currentUser.uid);
          }
        },
      ),
    );
  }
}
