import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_assets.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Components.dart';

class SectionsIcon extends StatefulWidget {
  final int index;
  final Function() onTap;

  final bool selectedTab;

  const SectionsIcon(
      {super.key,
      required this.index,
      required this.onTap,
      required this.selectedTab});

  @override
  State<SectionsIcon> createState() => _SectionsIconState();
}

class _SectionsIconState extends State<SectionsIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          minRadius: getWidth(10, context),
          maxRadius: getWidth(11, context),
          backgroundColor: widget.selectedTab
              ? AppColors.primaryColor.withOpacity(0.3)
              : AppColors.primaryColor.withOpacity(0.05),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Image.asset(AppAssets.homeTabLogo[widget.index]),
          ),
        ),
      ),
    );
  }
}
