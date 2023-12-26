import 'package:flutter/material.dart';

import '../../../../../config/utils/styles/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const ProfileCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 1,
      borderOnForeground: false,
      color: AppColors.primaryLight.withOpacity(0.9),
      child: ListTile(
          onTap: () {
            onTap();
          },
          tileColor: Colors.white.withOpacity(0.5),
          title: Text(
            title,
            style: const TextStyle(color: AppColors.blackDark),
          ),
          leading: Icon(icon)),
    );
  }
}
