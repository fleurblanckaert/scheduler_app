import 'package:flutter/material.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:scheduler_app/app/widgets/button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: const Text(
                "Welcome to the Event Scheduler!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: primary,
                ),
              ),
            ),
            SizedBox(height:80),
            // SizedBox(height: 30),
            Container(
                child: Center(
                  child: AppButton(
                    label: "Get Started",
                    onTap: () => null,
                  ),
                )
            ),
          ],
        ),
      ),

    );
  }
}