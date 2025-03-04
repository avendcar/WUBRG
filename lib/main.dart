import 'package:flutter/material.dart';
import 'package:flutter_application_3/profile_page.dart';

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
          leading: Builder(
            builder: (context) {
              return IconButton(
                color: Colors.white,
                iconSize: 40,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()),
                  );
                },
                icon: const Icon(Icons.account_balance),
              );
            }
          ),
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
                  Navigator.pop(context);
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
        body: Image.asset('images/mtg-background.png'),
      ),
    );
  }
}
