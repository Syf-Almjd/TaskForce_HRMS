import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';

import '../../../../../config/utils/managers/app_constants.dart';
import '../../../../../data/local/localData_cubit/local_data_cubit.dart';
import '../../../../../domain/Models/UserModel.dart';
import '../../../../Cubits/navigation_cubit/navi_cubit.dart';
import '../../../../Shared/Components.dart';
import '../../../../Shared/WidgetBuilders.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isObscure = true;
  bool changePassBtn = false;
  String? _imageBytes;
  final textForm = GlobalKey<FormState>();
  UserModel currentUser = UserModel.loadingUser();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    currentUser = await RemoteDataCubit.get(context).getUserData();
    _imageBytes = currentUser.photoID;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        // mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              _imageBytes = null;
              _pickFile();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                    : loadingAnimation(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: textForm,
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: currentUser.name,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        name.text = currentUser.name;
                        return null;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: currentUser.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        email.text = currentUser.email;
                        return null;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      labelText: currentUser.address,
                      prefixIcon: const Icon(Icons.home),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        address.text = currentUser.address;
                        return null;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneNumber,
                    decoration: InputDecoration(
                      labelText: currentUser.phoneNumber,
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        phoneNumber.text = currentUser.phoneNumber;
                        return null;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('New Password?'),
                      CupertinoSwitch(
                        applyTheme: true,
                        value: changePassBtn,
                        onChanged: (value) => setState(() {
                          changePassBtn = value;
                        }),
                      ),
                    ],
                  ),
                  if (changePassBtn)
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length <= 8) {
                          return "Password is short";
                        }
                        return null;
                      },
                      controller: newPass,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          labelText: 'New Password',
                          prefixIcon: const Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                    )
                ],
              ),
            ),
          ),
          loadButton(
              textSize: getWidth(5, context),
              textColor: Colors.white,
              buttonElevation: 2.0,
              onPressed: () {
                checkUserInput();
              },
              buttonText: "Update"),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  void checkUserInput() {
    if (validateForm(textForm)) {
      if (name.text.isEmpty) {}
      if (address.text.isEmpty) {
        address.text = currentUser.address;
      }
      if (phoneNumber.text.isEmpty) {
        phoneNumber.text = currentUser.phoneNumber;
      }
      if (email.text.isEmpty) {
        email.text = currentUser.email;
      }
      if (changePassBtn == true &&
          (newPass.text.isEmpty || newPass.text.length <= 8)) {
        currentUser.password = newPass.text;
        RemoteDataCubit.get(context).changePassword(newPass.text);
      }

      var userData = UserModel(
          email: email.text,
          password: currentUser.password,
          name: name.text,
          address: address.text,
          phoneNumber: phoneNumber.text,
          photoID: _imageBytes ?? currentUser.photoID,
          userID: FirebaseAuth.instance.currentUser!.uid,
          lastLogin: currentUser.lastLogin,
          lastAttend: currentUser.lastAttend,
          lastEleave: currentUser.lastEleave);

      LocalDataCubit.get(context)
          .saveSharedMap(AppConstants.savedUser, userData);
      RemoteDataCubit.get(context)
          .updateUserData(userData)
          .then((_) => NaviCubit.get(context).pop(context));
    }
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
