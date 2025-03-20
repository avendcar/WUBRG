import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';
import 'package:flutter_application_3/widgets/app_drawer.dart';

class DetailedEventPage extends StatelessWidget {
  const DetailedEventPage({super.key});
  //TODO: Create detailed event page and add navigation to this page.
  //Displays a single event with more detail, as opposed to the events page which displays many events with less detail.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar(),
      endDrawer: AppDrawer(),
      body: Text(
        'This is the decks page. Replace this widget with whatever.',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
