import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/profile_page.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

String username = "";
String bio = "";

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey();

  void _submit() {
    //TODO: Submit new info to database for updating
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Submitted! You may exit this page.'),
        duration: Duration(seconds: 2),
      ),
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
              bottom: MediaQuery.of(context).size.height * 0.25,
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
                  key: _formKey,
                  child: Column(
                    children: [
                      //TODO: Allow image submissions for profile picture
                      Center(
                        child: SizedBox(
                          width: 400,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(fontFamily: "Belwe"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(),
                                )),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'Invalid Username';
                              }
                              return null;
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
                              maxLines: null, //Increases height as user types
                              decoration: InputDecoration(
                                labelText: "Bio",
                                labelStyle: TextStyle(fontFamily: "Belwe"),
                                contentPadding: EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter bio text'),
                                    ),
                                  );
                                  return;
                                }
                                return null;
                              },
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
                        onPressed: _submit,
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
