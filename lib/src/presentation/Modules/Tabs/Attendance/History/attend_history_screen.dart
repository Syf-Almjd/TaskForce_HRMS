import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:taskforce_hrms/src/domain/Models/attendanceModel.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Tabs/Attendance/History/Builders/attend_history_card.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  List<AttendanceModel> attendanceList = [];
  bool _isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> getData() async {
    try {
      List<AttendanceModel> data =
          await RemoteDataCubit.get(context).getUserAttendanceHistory(context);

      if (mounted) {
        setState(() {
          attendanceList = data;
          _isloaded = true;
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Visibility(
        visible: _isloaded,
        replacement: loadingAnimation(),
        child: attendanceList.isEmpty
            ? const Center(child: Text("There are no records yet. All Set!"))
            : ListView(
                children: List.generate(attendanceList.length, (index) {
                  return Column(
                    children: [
                      AttendanceHistoryCard(
                          attendanceRecord: attendanceList[index]),
                      if (index != attendanceList.length - 1)
                        getDivider(context)
                    ],
                  );
                }),
              ),
      ),
    );
  }
}
