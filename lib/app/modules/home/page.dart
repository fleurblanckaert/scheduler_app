import 'package:flutter/material.dart';
import 'package:scheduler_app/app/services/theme.services.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: Column(
        children: const [
          Text("Theme Data", 
            style: TextStyle(
              fontSize: 30 
            )),
        ],
      ),
    );
  } 
}

_createAppBar() {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        ThemeService().switchTheme();
      },
      child: const Icon(
          Icons.nightlight_round, 
          size: 20,
        ),
    ),
    actions: const [
      Icon(
        Icons.settings,
        size: 20,
      ),
      SizedBox(width: 20,),
    ],
  );
}