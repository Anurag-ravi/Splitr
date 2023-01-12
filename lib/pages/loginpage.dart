// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splitr/components/form/input_box.dart';
import 'package:splitr/config/appwrite.dart';
import 'package:splitr/config/colors.dart';
import 'package:http/http.dart' as http;
import 'package:splitr/models/usermodel.dart';
import 'package:splitr/pages/otppage.dart';
import 'package:splitr/pages/signuppage.dart';
import 'package:splitr/utilities/data.dart';
import 'package:splitr/utilities/functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  String email = "";
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: ListView(
      children: [
          SizedBox(
            height: deviceHeight * 0.1,
          ),
          Center(
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/splitr.png'),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Center(
            child: Text(
              '  Splitr',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.025,
          ),
          InputText(controller: emailController, variable: email, name: "Email"),
          SizedBox(
            height: deviceHeight * 0.025,
          ),
          InkWell(
            onTap: () async {
              await signup();
            },
            child: Container(
              width: deviceWidth * .90,
              height: deviceWidth * .14,
              decoration: BoxDecoration(
                color: getPrimary(context),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: deviceWidth * .040,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.015,
          ),
          Container(
            width: deviceWidth ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: deviceWidth * .040,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: getPrimary(context),
                          fontSize: deviceWidth * .040,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.015,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: deviceWidth * .39,
                color: Colors.grey[400],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'OR',
                style: TextStyle(
                    fontSize: deviceWidth * .040, color: Colors.grey[700]),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 1,
                width: deviceWidth * .39,
                color: Colors.grey[400],
              ),
            ],
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          // sign in with google button
          InkWell(
            onTap: () => {account.createOAuth2Session(provider: 'google')},
            child: Container(
              width: deviceWidth * .90,
              height: deviceWidth * .14,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.6,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: deviceWidth * .040,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
        ));
  }
  signup() async {
    String email = emailController.text;
    FocusManager.instance.primaryFocus?.unfocus();
    if (isValidEmail(email)) {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "email": email,
        })
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      if(data['status']==200){
        showBar(data["message"],context);
        User user = User.fromJson(data['user']);
        Navigator.push(context, MaterialPageRoute(builder: (builder) => OTPPage(hash: data['hash'],user: user,)));

      } else {
        showBar(data["message"],context);
      }
    } else {
      showBar("Please, fill up the details",context);
    }
  }
  bool isValidEmail(String email) {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
    }
}