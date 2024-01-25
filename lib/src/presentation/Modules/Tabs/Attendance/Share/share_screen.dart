import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

class ShareAttendanceScreen extends StatefulWidget {
  const ShareAttendanceScreen({super.key});

  @override
  State<ShareAttendanceScreen> createState() => _ShareAttendanceScreenState();
}

class _ShareAttendanceScreenState extends State<ShareAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Attendance"),
      ),
      body: Center(
        child: loadingAnimation(),
      ),
    );
  }
}
