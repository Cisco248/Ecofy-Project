import 'package:flutter/material.dart';
import 'package:wms_app/main_layout.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

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
        title: Text("Supoort Us"),
      ),
      body: SafeArea(child: Center(child: Text("Support Page"))),
    );
  }
}
