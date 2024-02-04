import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_enums.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import '../../../../domain/Models/attendanceModel.dart';
import '../../../Shared/WidgetBuilders.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<DateTime> dates = [];
  @override
  void initState() {
    getDates();
    super.initState();
  }

  getDates() async {
    List<AttendanceModel> data = await RemoteDataCubit.get(context)
        .getUserAttendanceHistory(context)
        .then((value) => value.cast<AttendanceModel>().reversed.toList());
    for (var element in data) {
      dates.add(DateTime.parse(element.dateTime));
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var tabsList = AttendanceTabButtons.values;
    return Column(
      children: [
        getFeaturesButtons(featuresList: tabsList, context: context),
        getCube(4, context),
        getAppCalender(
            context: context,
            selectedDates: dates,
            firstDay: DateTime.utc(2023, 11, 1)),
      ],
    );
  }
}
