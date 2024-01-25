import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Attendance'),
                CupertinoSwitch(
                  applyTheme: true,
                  value: true,
                  onChanged: (value) => setState(() {
                    // changePassBtn = value;
                  }),
                ),
              ],
            )
          ]),
        ));
  }
}
