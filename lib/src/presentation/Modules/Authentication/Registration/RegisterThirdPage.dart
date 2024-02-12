import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';

import '../../../../data/local/localData_cubit/local_data_cubit.dart';
import '../../../../domain/Models/UserModel.dart';
import '../../../Cubits/navigation_cubit/navi_cubit.dart';
import '../../../Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import '../../../Shared/Components.dart';
import '../../../Shared/WidgetBuilders.dart';

class RegisterThirdPage extends StatefulWidget {
  final UserModel previousUserData;

  const RegisterThirdPage({Key? key, required this.previousUserData})
      : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  late UserModel userData;
  DateTime timeNow = DateTime.now();
  String? _imageBytes;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2), shape: BoxShape.circle),
              child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: getWidth(10, context),
                ),
                onTap: () {
                  BlocProvider.of<RegisterNavigationBloc>(context)
                      .add(TabChange(2));
                },
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            "Smile!",
            style:
                TextStyle(color: Colors.black, fontSize: getWidth(10, context)),
            textAlign: TextAlign.center,
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            _imageBytes = null;
            _pickFile();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              height: getHeight(20, context),
              width: getWidth(45, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
                color: Colors.grey.withOpacity(0.2),
              ),
              child: (_imageBytes != null)
                  ? previewImage(
                      onTap: () {
                        _imageBytes = null;
                        _pickFile();
                      },
                      photoRadius: 20,
                      context: context,
                      fileUser: _imageBytes,
                      editable: true)
                  : chooseFile(context),
            ),
          ),
        ),
        getCube(1, context),
        loadButton(
          buttonHeight: getHeight(5, context),
          buttonWidth: getWidth(50, context),
          textSize: getWidth(4, context),
          textColor: Colors.blueGrey,
          buttonElevation: 0.0,
          onPressed: () {
            signUser(AppConstants.noPhotoUser);
          },
          buttonText: 'Skip',
        ),
        getCube(2, context),
        Center(
            child: loadButton(
                buttonText: "Start!",
                onPressed: () {
                  if (_imageBytes != null) {
                    signUser(_imageBytes);
                  } else {
                    showToast('Choose a photo', Colors.red, context);
                  }
                })),
      ],
    );
  }

  Future<void> signUser(imageBytes) async {
    userData = UserModel(
        email: widget.previousUserData.email,
        password: widget.previousUserData.password,
        name: widget.previousUserData.name,
        lastAttend: "Unknown",
        phoneNumber: widget.previousUserData.phoneNumber,
        lastEleave: "Unknown",
        photoID: imageBytes,
        userID: "",
        lastLogin: timeNow.toString(),
        address: widget.previousUserData.address);
    RemoteDataCubit.get(context).userRegister(userData, context).then((value) {
      if (value) {
        LocalDataCubit.get(context)
            .saveSharedMap(AppConstants.savedUser, userData);
        NaviCubit.get(context).navigateToHome(context);
      } else {
        BlocProvider.of<RegisterNavigationBloc>(context).add(TabChange(2));
      }
    });
  }

  void _pickFile() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      Uint8List bytesUint8List = Uint8List.fromList(bytes);
      setState(() {
        _imageBytes = base64Encode(bytesUint8List);
      });
    }
  }
}
