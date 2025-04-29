class User {
  final String uid;
  final String username;
  final String? bio;
  final String? profileImageUrl;
  final List<String> tags;
  final List<String> joinedEvents; // List of event IDs or names

  User({
    required this.uid,
    required this.username,
    this.bio,
    this.profileImageUrl,
    required this.tags,
    required this.joinedEvents,
  });

  factory User.fromFirestore(Map<String, dynamic> data, String documentId) {
    return User(
      uid: documentId,
      username: data['username'] ?? '',
      bio: data['bio'],
      profileImageUrl: data['profileImageUrl'],
      tags: List<String>.from(data['tags'] ?? []),
      joinedEvents: List<String>.from(data['joinedEvents'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'tags': tags,
      'joinedEvents': joinedEvents,
    };
  }
}
