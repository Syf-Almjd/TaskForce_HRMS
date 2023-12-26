import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';

import '../../../../config/utils/managers/app_enums.dart';
import '../../../Shared/Components.dart';

class EleavePage extends StatelessWidget {
  const EleavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tabsList = EleaveTabButtons.values;
    return Column(
      children: [
        getFeaturesButtons(featuresList: tabsList, context: context),
        getCube(4, context),
        getAppCalender(
            context: context,
            selectedDates: [
              DateTime.utc(2023, 12, 1),
              DateTime.utc(2023, 12, 2)
            ],
            firstDay: DateTime.utc(2023, 11, 1)),
      ],
    );
  }
}
