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
            const SizedBox(height:40),
            Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // RichText(
                      //   text: const TextSpan(
                      //     text: 'Hello',
                      //     style: TextStyle(color: Colors.black),
                      //     children: <TextSpan>[
                      //       TextSpan(text: 'Yo')
                      //     ]
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(left:15, right: 15),
                        child: Text(
                          "This app provides you with all the tools you need to keep yourself organized."
                          " Schedule your events and view them all in a list by day or monthly calendar view.",
                          style: subHeadingStyle(),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      AppButton(
                        label: "Get Started",
                        onTap: () => Get.toNamed(Routes.HOME)
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),

    );
  }
}