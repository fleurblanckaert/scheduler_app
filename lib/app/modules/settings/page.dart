import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:scheduler_app/app/modules/settings/controller.dart';
import 'package:scheduler_app/app/services/notification.services.dart';
import 'package:scheduler_app/app/services/theme.services.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';
import 'package:scheduler_app/app/widgets/button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late NotifyHelper notifyHelper;
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();

    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildDarkModeGroup(),
            _buildDataGroup(),
          ],
        ),
      )
    );
  }

  _createAppBar() {

    return AppBar(
      title: Text(
        "Settings", 
        style: titleStyle(),
      ),
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

  _buildDarkModeGroup() {
    return SettingsGroup(
      title: "Dark Mode",
      children: [
        SwitchSettingsTile(
          title: "Dark Mode",
          defaultValue: Get.isDarkMode, 
          leading: const Icon(
            Icons.dark_mode,
            color: Color(0xFF642ef3),
          ),
          onChange: (_) { 
            ThemeService().switchTheme(); 
            notifyHelper.displayNotification(
              title: "Theme Changed", 
              body: !Get.isDarkMode ? "Activated Dark Theme" : "Activated Light Theme"
            );
          }, 
          settingKey: 'darkModeSetting',
        ),
      ]
    );
  }

  _buildDataGroup() {
    return SettingsGroup(
      title: "Data", 
      children: [
        SimpleSettingsTile(
          leading: const Icon(
            Icons.delete,
          ),
          title: "Delete All Data?",
          subtitle: "This will delete your tasks",
          child: Container(),
          onTap: () async {
            print("${await _settingsController.deleteAllData()} rows deleted from the table.");
            Get.back();
          },
        ),
      ],
    );
  }
}
