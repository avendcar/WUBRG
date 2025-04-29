// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/app_bar.dart';
import '../widgets/app_drawer.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/models/user.dart' as model;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  PlatformFile? _pickedFile;
  String? _currentImageUrl;
  List<String> _tags = [];
  bool _loading = false;

  final List<String> _availableTags = [
    "Casual",
    "Competitive",
    "18+",
    "Prefers any format",
    "Prefers commander format",
    "Prefers standard format",
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _loading = true);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        _usernameController.text = data['username'] ?? '';
        _bioController.text = data['bio'] ?? '';
        _tags = List<String>.from(data['tags'] ?? []);
        _currentImageUrl = data['profileImageURL']; // ✅ updated to match Firestore rules
      }
    }
    setState(() => _loading = false);
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() => _pickedFile = result.files.first);
    }
  }

  void _toggleTag(String tag) {
    setState(() {
      _tags.contains(tag) ? _tags.remove(tag) : _tags.add(tag);
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.')),
      );
      return;
    }

    String? imageUrl = _currentImageUrl;

    if (_pickedFile != null) {
      try {
        final file = File(_pickedFile!.path!);

        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_images/${user.uid}/profile.jpg');

        await ref.putFile(file);
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image upload failed: $e')),
        );
        return;
      }
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'username': _usernameController.text.trim(),
        'bio': _bioController.text.trim(),
        'tags': _tags,
        'profileImageURL': imageUrl, // ✅ updated here
      });

      MainPage.signedInUser = model.User(
        uid: user.uid,
        username: _usernameController.text.trim(),
        bio: _bioController.text.trim(),
        profileImageUrl: imageUrl,
        tags: _tags,
        joinedEvents: MainPage.signedInUser?.joinedEvents ?? [],
      );

      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PersistentAppBar(),
      endDrawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/mtg-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Text(
                          "Edit Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, fontFamily: "Belwe"),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.black87),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Enter a username' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _bioController,
                          decoration: const InputDecoration(
                            labelText: "Bio",
                            labelStyle: TextStyle(color: Colors.black87),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _loading ? null : _pickFile,
                          icon: const Icon(Icons.upload),
                          label: const Text("Upload Profile Image"),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: _pickedFile != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(File(_pickedFile!.path!)),
                                )
                              : (_currentImageUrl != null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(_currentImageUrl!),
                                    )
                                  : const CircleAvatar(
                                      radius: 60,
                                      child: Icon(Icons.person),
                                    )),
                        ),
                        const SizedBox(height: 16),
                        const Text("Select Tags:", style: TextStyle(fontWeight: FontWeight.bold)),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: _availableTags.map((tag) {
                            return FilterChip(
                              label: Text(tag),
                              selected: _tags.contains(tag),
                              onSelected: (_) => _toggleTag(tag),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _loading ? null : _saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text("Save", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
