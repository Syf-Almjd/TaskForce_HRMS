import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskforce_hrms/Shared/Components.dart';
import 'package:taskforce_hrms/State/AppDataCubit/data_cubit.dart';
import 'package:taskforce_hrms/State/AppEventsBloC/app_bloc.dart';
import 'package:taskforce_hrms/State/Singleton.dart';

import '../../../Models/UserModel.dart';
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
  var fileUser;

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
                  BlocProvider.of<BaBBloc>(context).add(TabChange(2));
                },
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            "Upload your Smile!",
            style: fontPoppins(size: getWidth(10, context)),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: getHeight(15, context),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(500),
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Center(
              child: InkWell(
                onTap: () async {},
                child: Stack(
                  children: [
                    Center(
                      child: (fileUser != null)
                          ? fileChosen(fileUser, context)
                          : chooseFile(context),
                    ),
                    Positioned(
                      bottom: 1,
                      left: getWidth(55, context),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black12),
                        child: const Icon(
                          Icons.mode_edit_outline_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Center(
            child: loadButton(
                buttonText: "Start!",
                onPressed: () {
                  if (fileUser != null) {
                    userData = UserModel(
                        email: widget.previousUserData.email,
                        password: widget.previousUserData.password,
                        name: widget.previousUserData.name,
                        phoneNumber: widget.previousUserData.phoneNumber,
                        photoID: "PHOTO ENCODE",
                        //fileuserData
                        userID: "",
                        lastLogin: timeNow.toString(),
                        address: widget.previousUserData.address);
                    BlocProvider.of<UserRegisterBloc>(context)
                        .add(UpdateUserEvent(userData));
                    AppCubit.get(context).userRegister(
                        Singleton().userDataToBeUploaded, context);
                  }
                })),
        getCube(5, context),
      ],
    );
  }

  void _pickFile() async {
    var pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      try {
        var file = pickedFile!.files.first.bytes;
        setState(() {
          fileUser = file;
        });
      } catch (err) {
        print(err);
      }
    } else {
      print('No Image Selected');
    }
  }
}
