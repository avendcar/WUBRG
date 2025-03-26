import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';
import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

String _username = '';
String _bio = '';
PlatformFile? pickedFile;
File? profilePicture;
String getUsername() {
  return _username;
}

String getBio() {
  return _bio;
}

//TODO: Link up username, bio, and profile picture to database

//TODO: Restrict access to only allow access to this page for admins and the profile owner

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(
      () {
        pickedFile = result.files.first;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar(),
      endDrawer: AppDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/mtg-background.png"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
              bottom: MediaQuery.of(context).size.height * 0.2,
              right: MediaQuery.of(context).size.width * 0.3,
              left: MediaQuery.of(context).size.width * 0.3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Scaffold(
              backgroundColor: Colors.white, //Color of form
              appBar: AppBar(
                leadingWidth: 220,
                leading: SizedBox(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                    child: Text("Go back to profile page",
                        style: TextStyle(
                            fontFamily: "Belwe", color: Colors.black)),
                  ),
                ),
                title: Text("Edit Profile"),
                centerTitle: true,
                backgroundColor: Colors.grey, //Color of app bar
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    children: [
                      //TODO: Allow image submissions for profile picture
                      Center(
                        child: SizedBox(
                          width: 400,
                          child: TextFormField(
                            maxLength: 20,
                            controller: _usernameController..text = _username,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: "Belwe"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Invalid Username';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value!;
                              //Sets username to the value in the username text field when the submit button is pressed
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            //Bio field measurements
                            width: 500,
                            child: TextFormField(
                              maxLength: 500,
                              controller: _bioController
                                ..text =
                                    _bio, //Sets the initial value as the current bio,

                              maxLines: null, //Increases height as user types
                              decoration: InputDecoration(
                                labelStyle: TextStyle(fontFamily: "Belwe"),
                                contentPadding: EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              validator: (value) {
                                return null;
                              },
                              onSaved: (value) {
                                _bio = value!;
                                //Sets bio to the value in the bio text field when the submit button is pressed
                              },
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(Colors.grey),
                          ),
                          onPressed: selectFile,
                          child: Text("Change profile picture"),
                        ),
                      ),

                      if (pickedFile != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Container(
                              width: 175,
                              height: 175,
                              color: Colors.blue,
                              child: Image.file(
                                File(pickedFile!.path!),
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      TextButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide()),
                          ),
                        ),
                        onPressed: () {
                          if (_formGlobalKey.currentState!.validate()) {
                            _formGlobalKey.currentState!.save();
                            setState(() {
                              //Refreshes page after submission
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Information saved! You may exit this page.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: "Belwe", color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
