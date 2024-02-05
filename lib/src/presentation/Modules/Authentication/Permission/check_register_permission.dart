import 'package:flutter/material.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Shared/WidgetBuilders.dart';

import '../../../Shared/Components.dart';

class CheckRegisterPermission extends StatefulWidget {
  const CheckRegisterPermission({super.key});

  @override
  State<CheckRegisterPermission> createState() =>
      _CheckRegisterPermissionState();
}

class _CheckRegisterPermissionState extends State<CheckRegisterPermission> {
  TextEditingController code = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Please Input Staff Registration Code!"),
          TextFormField(
            key: formKey,
            validator: (value) {
              if (value!.isEmpty || value.length <= 4) {
                showToast("Wrong Code", Colors.red, context);
                return "Wrong Code";
              }
              return null;
            },
            controller: code,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: 'Password',
              prefixIcon: const Icon(Icons.password_outlined),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            child: loadButton(
                textSize: 10,
                buttonElevation: 0,
                textColor: Colors.white,
                buttonHeight: getHeight(7, context),
                buttonWidth: getWidth(15, context),
                onPressed: () {
                  if (validateForm(formKey)) {
                    RemoteDataCubit.get(context)
                        .getRegistrationKey(code.text, context);
                  }
                },
                buttonText: "Validate"),
          )
        ],
      ),
    );
  }
}
