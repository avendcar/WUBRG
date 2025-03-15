import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: PersistentAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/mtg-background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //TODO: populate containers with smaller boxes and data
            SizedBox(height: 150),
            Opacity(
              opacity: 0.5,
              child: Container(
                  color: Colors.red,
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.8),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                  color: Colors.blue,
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.8),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                  color: Colors.green,
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
