import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/Models/UserModel.dart';
import '../../../Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import '../../../Shared/Components.dart';
import '../../../Shared/WidgetBuilders.dart';

class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  late UserModel userData;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  final _validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _validateKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        // mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: getWidth(10, context),
                  ),
                  onTap: () {
                    BlocProvider.of<RegisterNavigationBloc>(context)
                        .add(TabChange(0));
                  },
                ),
              ),
              Center(
                child: Text(
                  "Register",
                  style: fontLobster(size: getWidth(15, context)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      showToast("Your name is empty!", Colors.red, context);
                      return 'Your name is empty';
                    } else {
                      return null;
                    }
                  },
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Full Name",
                    prefixIcon: const Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.name,
                ),
                getCube(2, context),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('0')) {
                      showToast("Your number is invalid!", Colors.red, context);
                      return 'Your number is invalid';
                    } else {
                      return null;
                    }
                  },
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.number,
                ),
                getCube(2, context),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 8) {
                      showToast("Your address is short!", Colors.red, context);
                      return 'Your address is short';
                    } else {
                      return null;
                    }
                  },
                  controller: address,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(100),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Work Address",
                    prefixIcon: const Icon(Icons.place_outlined),
                  ),
                  keyboardType: TextInputType.streetAddress,
                ),
              ],
            ),
          ),
          Center(
              child: loadButton(
                  buttonText: "Next",
                  onPressed: () {
                    if (validateForm(_validateKey)) {
                      userData = UserModel(
                          email: "",
                          password: "",
                          name: name.text,
                          phoneNumber: phoneNumber.text,
                          photoID: "",
                          userID: "",
                          lastLogin: "",
                          address: address.text);
                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(UpdateUserEvent(userData));
                      BlocProvider.of<RegisterNavigationBloc>(context)
                          .add(TabChange(2));
                    }
                  })),
          getCube(5, context),
        ],
      ),
    );
  }
}
