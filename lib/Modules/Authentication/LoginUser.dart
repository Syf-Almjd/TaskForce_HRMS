import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:taskforce_hrms/generated/assets.dart';
import '../../Components/Components.dart';
import '../../Cubit/AppDataCubit/app_cubit.dart';
import '../../Cubit/Navigation/navi_cubit.dart';
import 'RegisterUser.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _isObscure = true;
  bool _isLoading = false;

  var emailData, passData;
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
                border: Border.all(width: 2, color: Colors.yellow),
              ),
              child: const Image(
                  image: AssetImage(Assets.assetsLogoTransparent),
                  fit: BoxFit.contain),
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: pass,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
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
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      child: Text(
                        "Don't Have an account?",
                        style:
                            fontAlmarai(size: 11, textColor: Colors.lightBlue),
                        textAlign: TextAlign.right,
                      ),
                      onTap: () {
                        NaviCubit.get(context)
                            .navigateOff(context, const register());
                      }),
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
                      onPressed: () {
                        if (email.text.isEmpty || !email.text.contains('@')) {
                          showToast("Wrong Email", SnackBarType.fail ,context);
                        } else if (pass.text.isEmpty || pass.text.length <= 4) {
                          showToast("Wrong Password", SnackBarType.fail ,context);
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          AppCubit.get(context)
                              .userLogin(email.text, pass.text, context);
                        }
                      },
                      child: Text(
                        "Login",
                        style: fontAlmarai(
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black),
                      ),
                    ),
                  ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
