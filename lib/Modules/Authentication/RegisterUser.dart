import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import '../../Components/Components.dart';
import '../../Cubit/AppDataCubit/app_cubit.dart';
import '../../Cubit/Navigation/navi_cubit.dart';
import '../../Models/UserModel.dart';
import '../../generated/assets.dart';
import 'LoginUser.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  bool _isObscure = true;
  bool _isLoading = false;

  late UserModel userData;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          // mainAxisSize: MainAxisSize.min,
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
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                    controller: address,
                    decoration: const InputDecoration(
                      labelText: "Address",
                      prefixIcon: Icon(Icons.home),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: phoneNumber,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.number,
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
                  TextField(
                    controller: pass2,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
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
                        child: Text(
                          "Already have an account?",
                          style: fontAlmarai(
                              size: 11, textColor: Colors.lightBlue),
                          textAlign: TextAlign.right,
                        ),
                        onTap: () {
                          NaviCubit.get(context)
                              .navigateOff(context, const login());
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
                        onPressed: () async {
                          if (name.text.isEmpty) {
                            showToast("Name not given", SnackBarType.fail ,context);
                          } else if (address.text.isEmpty) {
                            showToast("Address not given", SnackBarType.fail ,context);
                          } else if (phoneNumber.text.isEmpty) {
                            showToast("Number not given", SnackBarType.fail ,context);
                          } else if (email.text.isEmpty ||
                              !email.text.contains('@')) {
                            showToast("Email is incorrect!", SnackBarType.fail ,context);
                          } else if (pass.text.isEmpty ||
                              pass.text.length <= 4) {
                            showToast("Very short password", SnackBarType.fail ,context);
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email.text, password: pass.text);
                            } on FirebaseAuthException {
                              IconSnackBar.show(
                                  context: context,
                                  snackBarType: SnackBarType.fail,
                                  label: 'Try again!');
                              AppCubit.get(context).stopLoading();
                            }

                            userData = UserModel(
                                email: email.text,
                                password: pass.text,
                                name: name.text,
                                address: address.text,
                                points: "10",
                                phoneNumber: phoneNumber.text,
                                photoID: FirebaseAuth.instance.currentUser!.uid,
                                userID: FirebaseAuth.instance.currentUser!.uid);
                            AppCubit.get(context)
                                .userRegister(userData, context);
                          }
                        },
                        child: Text(
                          "Register",
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
      ),
    );
  }
}
