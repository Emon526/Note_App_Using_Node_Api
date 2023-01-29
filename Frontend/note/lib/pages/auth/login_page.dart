// import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/pages/auth/register_page.dart';
import 'package:note/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(text: 'emon@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');
  bool passvisibility = true;
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();

  void validateAndLogin() async {
    final FormState form = _loginformKey.currentState!;
    if (form.validate()) {
      AuthProvider().loginUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 50,
          ),
          child: Form(
            key: _loginformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    String pattern =
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value!) || value.isEmpty) {
                      return 'Enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.email,
                      size: 24,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: passvisibility,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('')) {
                      return 'Enter Password';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffix: InkWell(
                      child: Icon(
                        passvisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () {
                        setState(() {
                          passvisibility = !passvisibility;
                        });
                      },
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 24,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        validateAndLogin();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                // Center(
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.pushReplacementNamed(
                //           context, '/ForgotPassword');
                //     },
                //     child: const Text(
                //       "Forgot Password??",
                //       style: TextStyle(
                //         color: Colors.red,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Doesn't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
