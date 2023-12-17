import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/navigation_cubit/navi_cubit.dart';

import '../../../Shared/Components.dart';

class InTabButton extends StatelessWidget {
  final String buttonName;
  final Widget naviWidget;
  const InTabButton(
      {Key? key, required this.buttonName, required this.naviWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          NaviCubit.get(context).navigate(context, naviWidget);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          height: getHeight(10, context),
          width: getWidth(20, context),
          child: Center(
              child: Text(
            buttonName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
