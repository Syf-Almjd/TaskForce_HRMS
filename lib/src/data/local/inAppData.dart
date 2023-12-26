import 'package:flutter/cupertino.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../config/utils/managers/app_assets.dart';
import '../../presentation/Shared/Components.dart';

List<String> homeMenuIcons = [
  "Home",
];

List<PageViewModel> listPagesViewModel(context) => [
      PageViewModel(
        title: 'Welcome',
        body: 'Confidentiality',
        image: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset(AppAssets.assetsTFLogo),
          ),
        ),
      ),
      PageViewModel(
        title: '',
        body: 'Integrity',
        image: Center(
          child: Image.network(
              "https://i.pinimg.com/originals/0c/28/08/0c28087b5cedf7276ee6c8d81e28d328.gif",
              height: getHeight(50, context)),
        ),
      ),
      PageViewModel(
        title: "Let's get Started",
        body: 'Availability',
        image: Center(
          child: Image.network(
              "https://i.pinimg.com/originals/03/a9/23/03a923c621632e6e80b675909ababb9d.gif",
              height: getHeight(50, context)),
        ),
      ),
    ];
