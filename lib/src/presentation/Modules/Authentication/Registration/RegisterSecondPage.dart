import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

import '../../../../domain/Models/UserModel.dart';
import '../../../Shared/Components.dart';
import '../../../Shared/WidgetBuilders.dart';
import '../../Cubits/appNavi_cubit/navi_cubit.dart';
import '../../Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import '../Login/LoginUser.dart';

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
                      showToast("Your email is incorrect!", SnackBarType.fail,
                          context);
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
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                getCube(2, context),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 8) {
                      showToast("Use a stronger password!", SnackBarType.fail,
                          context);
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
                      showToast("Your password doesn't match!",
                          SnackBarType.fail, context);
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
                        NaviCubit.get(context)
                            .navigateOff(context, const Login());
                      }),
                ),
              ],
            ),
          ),
          Center(
              child: loadButton(
                  buttonText: "Finalize..",
                  onPressed: () {
                    if (validateForm(_validateKey)) {
                      userData = UserModel(
                          email: email.text,
                          password: password.text,
                          name: widget.previousUserData.name,
                          phoneNumber: widget.previousUserData.name,
                          photoID: "",
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
