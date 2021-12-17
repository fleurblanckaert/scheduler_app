import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:scheduler_app/app/widgets/input_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Task",
                  style: headingStyle(),
                ),
                const AppInputField(title: "Title", hint: "Enter your title",),
                const AppInputField(title: "Note", hint: "Enter your note",),
              ],
            ),
          ),
        ),
    );
  }

  _createAppBar() {

    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
            Icons.chevron_left_outlined, 
            size: 20,
            color: Colors.white,
          ),
      ),
    );
  }
}