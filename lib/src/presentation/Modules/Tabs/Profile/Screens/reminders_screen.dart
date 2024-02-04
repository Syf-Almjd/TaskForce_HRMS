import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reminders"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView(
              padding: EdgeInsets.only(bottom: 15),
              children: List.generate(
                  AppConstants.remindersButtonsNames.length,
                  (index) =>
                      switchButton(AppConstants.remindersButtonsNames[index])),
            )));
  }

  switchButton(name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(name),
        CupertinoSwitch(
            applyTheme: true,
            value: false,
            onChanged: (value) =>
                showToast("Coming Soon!", AppColors.primaryColor, context)
            //     setState(() {
            //   // changePassBtn = value;
            // }
            ),
      ],
    );
  }
}
