import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler_app/app/routes/app_pages.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:scheduler_app/app/widgets/button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
            const SizedBox(height:80),
            // SizedBox(height: 30),
            Container(
                child: Center(
                  child: AppButton(
                    label: "Get Started",
                    onTap: () => Get.toNamed(Routes.HOME)
                  ),
                )
            ),
          ],
        ),
      ),

    );
  }
}