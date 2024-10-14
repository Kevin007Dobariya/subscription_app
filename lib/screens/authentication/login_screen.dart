import 'package:flutter/material.dart';

import '../../utils/comman_widget/PvjTextWidget.dart';
import '../../utils/comman_widget/pvj_round_corner_tf.dart';
import '../user_list/user_list_screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String role = 'User'; // Default role selection
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const HeadlineBodyOneBaseWidget(
          "Sign In",
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        backgroundColor: Colors.white54,
        elevation: 0,
        centerTitle: true,
        /*actions: [
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.arrow_right_alt_rounded))
        ],*/
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: Colors.white54,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: PvjRoundCornerTf(
                      controller: emailController,
                      labelText: "Enter email address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: PvjRoundCornerTf(
                      labelText: 'Enter Password',
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio<String>(
                        value: 'User',
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value!;
                          });
                        },
                      ),
                      const HeadlineBodyOneBaseWidget('User', fontSize: 16),
                      const SizedBox(width: 20),
                      Radio<String>(
                        value: 'Admin',
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value!;
                          });
                        },
                      ),
                      const HeadlineBodyOneBaseWidget('Admin', fontSize: 16),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: HeadlineBodyOneBaseWidget(
                      "forgot password?",
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 25.0),
                    child: SizedBox(
                      width: 335,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserListScreens()),
                            );

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter details")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const HeadlineBodyOneBaseWidget("Sign In",
                            titleColor: Colors.white),
                      ),
                    ),
                  ),
                /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New user?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () => {},
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      )
                    ],
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
