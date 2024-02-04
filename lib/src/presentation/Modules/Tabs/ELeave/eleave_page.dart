import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/domain/Models/eLeaveModel.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';

import '../../../../config/utils/managers/app_enums.dart';
import '../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../Shared/Components.dart';

class EleavePage extends StatefulWidget {
  const EleavePage({Key? key}) : super(key: key);

  @override
  State<EleavePage> createState() => _EleavePageState();
}

class _EleavePageState extends State<EleavePage> {
  List<DateTime> dates = [];
  @override
  void initState() {
    getDates();
    super.initState();
  }

  getDates() async {
    List<EleaveModel> data = await RemoteDataCubit.get(context)
        .getUserEleaveHistory(context)
        .then((value) => value.cast<EleaveModel>().reversed.toList());
    for (var element in data) {
      dates.add(DateTime.parse(element.dateTime));
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var tabsList = EleaveTabButtons.values;
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
