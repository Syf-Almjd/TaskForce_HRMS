import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/data/local/localData_cubit/local_data_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool isBioDisabled = false;

  @override
  void initState() {
    getSavedOptions();
    super.initState();
  }

  getSavedOptions() async {
    isBioDisabled = bool.parse(await LocalDataCubit.get(context)
        .getSharedData(AppConstants.userSkipLocalBio));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child:
              ListView(padding: const EdgeInsets.only(bottom: 15), children: [
            switchButton("Disable Biometric", isBioDisabled, (value) {
              LocalDataCubit.get(context).saveSharedData(
                  AppConstants.userSkipLocalBio, value.toString());
              setState(() {
                isBioDisabled = value;
              });
            }),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Reminders",
                style: TextStyle(color: AppColors.greyDark),
                textAlign: TextAlign.center,
              ),
            ),
            ...List.generate(
              AppConstants.remindersButtonsNames.length,
              (index) => switchButton(
                  AppConstants.remindersButtonsNames[index], false, (value) {
                showToast("Coming Soon!", AppColors.primaryColor, context);
              }),
            ),
          ]),
        ));
  }

  switchButton(name, statusValue, Function(bool) onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(name),
        CupertinoSwitch(applyTheme: true, value: statusValue, onChanged: onTap),
      ],
    );
  }
}
