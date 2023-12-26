import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_enums.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

import '../../../Shared/WidgetBuilders.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tabsList = AttendanceTabButtons.values;
    return Column(
      children: [
        getFeaturesButtons(featuresList: tabsList, context: context),
        getCube(4, context),
        getAppCalender(
            context: context,
            selectedDates: [
              DateTime.utc(2023, 12, 4),
              DateTime.utc(2023, 12, 2)
            ],
            firstDay: DateTime.utc(2023, 11, 1)),
      ],
    );
  }
}
