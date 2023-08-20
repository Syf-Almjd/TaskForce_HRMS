import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:taskforce_hrms/Components/Globals.dart';
import 'package:taskforce_hrms/Modules/Authentication/BioDS.dart';
import 'package:taskforce_hrms/generated/assets.dart';

import '../../Components/Components.dart';
import '../../Cubit/AppDataCubit/app_cubit.dart';
import '../../Cubit/Navigation/navi_cubit.dart';
import 'RegisterUser.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  bool _isLoading = false;
  int attempts = 0;
  bool isSuspicious = false;
  late String emailData, passData;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              width: getWidth(50, context),
              height: getHeight(20, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.blue),
              ),
              child: const Image(
                image: AssetImage(Assets.assetsLogoTransparent),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: pass,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text(
                      "Don't Have an account?",
                      style: fontAlmarai(size: 11, textColor: Colors.lightBlue),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      NaviCubit.get(context)
                          .navigateOff(context, const Register());
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: _isLoading
                ? loadingAnimation()
                : Container(
                    width: double.infinity,
                    height: 60.0,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: () async {
                        if (email.text.isEmpty || !email.text.contains('@')) {
                          showToast("Wrong Email", SnackBarType.fail, context);
                        } else if (pass.text.isEmpty || pass.text.length <= 4) {
                          showToast(
                              "Wrong Password", SnackBarType.fail, context);
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          var successfulLogin = await AppCubit.get(context)
                              .userLogin(email.text, pass.text, context);
                          if (!successfulLogin) {
                            setState(() {
                              _isLoading = false;
                            });
                          } else {
                            setState(() {
                              userAuth = true;
                            });
                          }
                        }
                      },
                      child: Text(
                        "Login",
                        style: fontAlmarai(
                            fontWeight: FontWeight.bold,
                            textColor: Colors.white),
                      ),
                    ),
                  ),
          ),
          getCube(5, context),
          (isSuspicious || !userAuth)
              ? Center(child: const Text("You must login with credentials!"))
              : InkWell(
                  onTap: () async {
                    var savedID = await getSharedData("userID");
                    var isVerified = await BioDS();
                    var UserData = await AppCubit.get(context).getUserData();

                    if (savedID == UserData.userID &&
                        mounted &&
                        isVerified &&
                        attempts <= 3) {
                      showToast("Successful!", SnackBarType.save, context);
                      NaviCubit.get(context).navigateToHome(context);
                    } else {
                      if (attempts >= 4 || savedID == null) {
                        setState(() {
                          isSuspicious = true;
                        });
                      }
                      attempts++;
                      showToast("Unsuccessful, try again", SnackBarType.fail,
                          context);
                    }
                  },
                  child: Icon(
                    Icons.fingerprint_outlined,
                    size: getWidth(35, context),
                    color: Colors.grey,
                  ),
                ),
          getCube(3, context),
        ],
      ),
    );
  }
}
