import 'dart:math';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          iconSize: 40,
          onPressed: () {
            // Navigate back or to HomePage
            Navigator.pop(context);
          },
          icon: const Icon(Icons.home),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Click for home ->',
              style: TextStyle(fontFamily: 'Belwe', color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.person, color: Colors.white),
          ),
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
            color: Colors.grey,
            width: 300,
            height: 300,
            child: Image.asset(
              'images/mtg-background.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class Hexagon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Define the hexagon shape using relative positions.
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height * sqrt(3) / 4);
    path.lineTo(size.width * 0.75, size.height * sqrt(3) / 2);
    path.lineTo(size.width * 0.25, size.height * sqrt(3) / 2);
    path.lineTo(0, size.height * sqrt(3) / 4);
    path.close(); // Call the close method to complete the path.
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
