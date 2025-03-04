import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/main.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[300],
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              color: Colors.white,
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(Icons.home),
            );
          }),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Click for home ->',
                style: TextStyle(fontFamily: 'Belwe', color: Colors.white),
              ),
            ),
            Builder(builder: (context) {
              return TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Icon(Icons.person, color: Colors.white),
              );
            }),
          ],
          title: Text(
            'Profile Page',
            style: TextStyle(fontFamily: 'Belwe', color: Colors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 120, top: 100),
          child: ClipPath(
            clipper: Hexagon(),
            child: Container(
                //Contains profile picture location
                color: Colors.grey,
                width: 300,
                height: 300,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset('images/mtg-background.png',
                            fit: BoxFit.fill))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class Hexagon extends CustomClipper<Path> {
  //Creates hexagon shape for profile picture
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.75, size.height * sqrt(3) / 2);
    path.lineTo(size.width * 0.25, size.height * sqrt(3) / 2);
    path.lineTo(0, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.25, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
