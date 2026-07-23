import 'package:flutter/material.dart';
import 'package:wms_app/main_layout.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainWrapper()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Help"),
      ),
      body: SafeArea(child: Center(child: Text("Help Page"))),
    );
  }
}
