import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/Models/UserModel.dart';
import '../../../Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import '../../../Shared/Components.dart';
import '../../../Shared/WidgetBuilders.dart';

class RegisterSecondPage extends StatefulWidget {
  final UserModel previousUserData;

  const RegisterSecondPage({super.key, required this.previousUserData});

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  bool _isObscure = true;
  late UserModel userData;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
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
                        .add(TabChange(1));
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                getCube(2, context),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      showToast(
                          "Your email is incorrect!", Colors.red, context);
                      return 'Your email is incorrect';
                    } else {
                      return null;
                    }
                  },
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                getCube(2, context),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 8) {
                      showToast(
                          "Use a stronger password!", Colors.red, context);
                      return 'Use a stronger password';
                    } else {
                      return null;
                    }
                  },
                  controller: password,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Password',
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
                ),
                getCube(2, context),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !(value == password.text)) {
                      showToast(
                          "Your password doesn't match!", Colors.red, context);
                      return "Your password doesn't match";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordConfirmation,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Confirm Password',
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
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      child: const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.blueAccent),
                        textAlign: TextAlign.right,
                      ),
                      onTap: () {
                        BlocProvider.of<RegisterNavigationBloc>(context)
                            .add(TabChange(0));
                      }),
                ),
              ],
            ),
          ),
          Center(
              child: loadButton(
                  buttonText: "Finalize..",
                  onPressed: () async {
                    if (validateForm(_validateKey)) {
                      userData = UserModel(
                          email: email.text,
                          password: password.text,
                          name: widget.previousUserData.name,
                          phoneNumber: widget.previousUserData.phoneNumber,
                          photoID: "",
                          lastAttend: "",
                          lastEleave: "",
                          userID: "",
                          address: widget.previousUserData.address,
                          lastLogin: "");

                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(UpdateUserEvent(userData));
                      BlocProvider.of<RegisterNavigationBloc>(context)
                          .add(TabChange(3));
                    }
                  })),
          getCube(5, context),
        ],
      ),
    );
  }
}
