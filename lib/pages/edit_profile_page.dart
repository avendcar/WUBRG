import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/objects/user.dart';
import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';
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

int currentUserId = MainPage.signedInUser.userId;
String _username = MainPage.signedInUser.username;
String _bio = MainPage.signedInUser.bio;
PlatformFile? pickedFile;
List<String> updatedTagList = MainPage.signedInUser.tags;

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

  void updateTag(String tag) {
    if (updatedTagList.contains(tag)) {
      updatedTagList.remove(tag);
    } else {
      updatedTagList.add(tag);
    }
  }

  Future<Image> convertFileToImage(File picture) async {
    Uint8List uint8list = await picture.readAsBytes();
    Image image = Image.memory(uint8list);
    return image;
  }

  Future<void> updateDataOnSubmit() async {
    User currentUser =
        userList.firstWhere((user) => user.userId == currentUserId);
    userList.remove(currentUser);
    userList.add(
      User(
          _username,
          currentUser.userId,
          _bio,
          await convertFileToImage(
              File(pickedFile?.path ?? "images/kuriboh.png")),
          updatedTagList,
          currentUser.joinedEvents),
    );

    MainPage.signedInUser.username = _username;
    MainPage.signedInUser.bio = _bio;
    MainPage.signedInUser.tags = updatedTagList;
    MainPage.signedInUser.profilePicture = await convertFileToImage(
        File(pickedFile?.path ?? "images/kuriboh.png"));
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
                            builder: (context) => const PersonalProfilePage()),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //TODO: Allow image submissions for profile picture on Linux(Works for windows)
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
                                if (value == null || value.isEmpty) {
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
                              overlayColor:
                                  WidgetStateProperty.all(Colors.grey),
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
                        Text(
                          "Current Tags : ",
                          style: TextStyle(fontSize: 18),
                        ),
                        for (String tag in updatedTagList) Text(tag),
                        if (updatedTagList.isEmpty)
                          Text(
                              "You currently have no tags associated with your profile."),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    updateTag("Prefers any format");
                                    setState(() {});
                                  },
                                  child: Text("Prefers any format"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    updateTag("Prefers commander format");
                                    setState(() {});
                                  },
                                  child: Text("Prefers commander format"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    updateTag("Prefers standard format");
                                    setState(() {});
                                  },
                                  child: Text("Prefers standard format"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    updateTag("Casual");
                                    setState(() {});
                                  },
                                  child: Text("Casual"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    updateTag("Competitive");
                                    setState(() {});
                                  },
                                  child: Text("Competitive"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    updateTag("18+");
                                    setState(() {});
                                  },
                                  child: Text("18+"),
                                ),
                              ],
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
                                updateDataOnSubmit();
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
                        SizedBox(height: 20),
                      ],
                    ),
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
