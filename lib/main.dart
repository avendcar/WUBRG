import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_page.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Here\'s some text',
                style: TextStyle(
                    fontFamily: 'Belwe', color: Colors.white, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Click for profile page ->',
                style: TextStyle(fontFamily: 'Belwe', color: Colors.white),
              ),
            ),
            Builder(builder: (context) {
              return TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
                child: Icon(Icons.person, color: Colors.white),
              );
            }),
          ],
          backgroundColor: Colors.black,
          title: Text(
            textAlign: TextAlign.center,
            'W U B R G',
            style: TextStyle(fontFamily: 'Belwe', color: Colors.white),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.deepPurple,
          child: ListView(
            children: [
              Center(
                child: const DrawerHeader(
                  padding: EdgeInsets.all(52),
                  decoration: BoxDecoration(color: Color(0xFF3F124D)),
                  child: Text(
                    "Here's the drawer header!",
                    style: TextStyle(fontFamily: 'Belwe', color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Option 1",
                  style: TextStyle(fontFamily: 'Belwe'),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  "Option 2",
                  style: TextStyle(fontFamily: 'Belwe'),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Image.asset('images/mtg-background.png'), 

        
      ),
    );
  }
}

