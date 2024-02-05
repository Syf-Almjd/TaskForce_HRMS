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
    return Form(
      key: formKey,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Please Input Staff Registration Code!"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length <= 6) {
                    showToast("Wrong Code", Colors.red, context);
                    return "Wrong Code";
                  }
                  return null;
                },
                controller: code,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Registration Code',
                  prefixIcon: const Icon(Icons.qr_code),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: loadButton(
                  textSize: 20,
                  buttonElevation: 0,
                  textColor: Colors.white,
                  buttonHeight: getHeight(7, context),
                  buttonWidth: getWidth(50, context),
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
      ),
    );
  }
}
