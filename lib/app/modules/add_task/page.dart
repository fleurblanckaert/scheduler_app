import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_app/app/data/models/task.dart';
import 'package:scheduler_app/app/modules/add_task/controller.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:scheduler_app/app/widgets/button.dart';
import 'package:scheduler_app/app/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({ Key? key }) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final AddTaskController _taskController = Get.put(AddTaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now().add(const Duration(hours: 2)));
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  int _selectedColor = 0;

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
                AppInputField(
                  title: "Title", 
                  hint: "Enter your title", 
                  controller: _titleController,
                ),
                AppInputField(
                  title: "Note", 
                  hint: "Enter your note", 
                  controller: _noteController,
                ),
                AppInputField(
                  title: "Date", 
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined, 
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppInputField(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                          icon: const Icon(Icons.access_time_rounded),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppInputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          icon: const Icon(Icons.access_time_rounded),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _createColorPalette(),
                    AppButton(
                      label: "Create Task", 
                      onTap: () => _validateForm()
                    )
                  ],
                ),
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

  _createColorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle(),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: List<Widget>.generate(
            5,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: 
                      index == 0 ? primary : 
                      index == 1 ? Colors.pink : 
                      index == 2 ? Colors.green :
                      index == 3 ? Colors.blue :
                      Colors.yellow,
                    child: _selectedColor == index ? const Icon(Icons.done, color: Colors.white, size: 15) : Container(),
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5), // Five years before current date
      lastDate: DateTime(DateTime.now().year + 25), // Twenty-Five years after current date
    );

    if (_pickerDate!= null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      // no op for now
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime?.format(context);

    if (pickedTime==null) {
      print("Time picking cancelled");

    } else if (isStartTime) {

      setState(() {
        _startTime = _formattedTime;
      });

    } else if (!isStartTime) {

      setState(() {
        _endTime = _formattedTime;
      });
      
    }

    print(_formattedTime);
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
    );
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        isCompleted: 0
      )
    );
    print("Task with ID $value was inserted into the database");
    
  }

  _validateForm() {

    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {

      // add data to the database
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required", 
        "All fields are required!",
        backgroundColor: Get.isDarkMode ? secondary : surface,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.warning_amber_rounded),
      );
    }

  }
}