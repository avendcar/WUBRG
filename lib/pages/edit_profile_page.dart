import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/app_bar.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(),
      child: Scaffold(
        appBar: PersistentAppBar(),
        body: Text("Here is some text"),
      ),
    );
  }
}
