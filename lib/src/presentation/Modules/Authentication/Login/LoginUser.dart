import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';

import '../../../Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import '../../../Shared/Components.dart';
import '../../../Shared/WidgetBuilders.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  late String emailData, passData;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _validateKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            "Login",
            style: fontLobster(size: getWidth(20, context)),
            textAlign: TextAlign.center,
          ),
          getCube(3, context),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      showToast(
                          "Your Email is incorrect!", Colors.red, context);
                      return "Your Email is incorrect";
                    }
                    return null;
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
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 4) {
                      showToast("Wrong Password", Colors.red, context);
                      return "Wrong Password";
                    }
                    return null;
                  },
                  controller: pass,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text(
                      "Don't have an account?",
                      softWrap: true,
                      style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      BlocProvider.of<RegisterNavigationBloc>(context)
                          .add(TabChange(1));
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
              child: loadButton(
                  buttonText: "Login",
                  onPressed: () {
                    if (validateForm(_validateKey)) {
                      RemoteDataCubit.get(context)
                          .userLogin(email.text, pass.text, context);
                    }
                  })),
        ],
      ),
    );
  }
}
