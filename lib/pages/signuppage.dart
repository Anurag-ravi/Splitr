// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splitr/components/form/input_box.dart';
import 'package:splitr/config/appwrite.dart';
import 'package:splitr/config/colors.dart';
import 'package:http/http.dart' as http;
import 'package:splitr/utilities/data.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String email = "", phone = "", name = "", upi = "";
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
          InputText(controller: nameController, variable: name, name: "Name"),
          SizedBox(
            height: deviceHeight * 0.015,
          ),
          InputText(controller: emailController, variable: email, name: "Email"),
          SizedBox(
            height: deviceHeight * 0.015,
          ),
          InputText(
              controller: phoneController, variable: phone, name: "Phone Number"),
          SizedBox(
            height: deviceHeight * 0.015,
          ),
          InputText(controller: upiController, variable: upi, name: "UPI ID"),
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
                  'Sign up',
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
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: deviceWidth * .040,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Sign in',
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
                        'Sign up with Google',
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
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String upi = upiController.text;
    FocusManager.instance.primaryFocus?.unfocus();
    if (isValidEmail(email) && isValidPhone(phone) && isValidUpi(upi)) {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "email": email,
          "upi_id": upi,
        })
      );
      var data = jsonDecode(response.body);
      print(data);
      // if(response.statusCode == 200){
      //   widget.prefs.setString('token', data['jwt']);
      //   widget.prefs.setString('username', data['username']);
      //   widget.prefs.setInt('id', data['id']);
      //   widget.prefs.setString('dp', data['dp']);
      //   const snackBar = SnackBar(
      //   content: Text('Succcessfully Logged in'),
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   Navigator.push(context, MaterialPageRoute(builder: (builder) => HomePage(prefs: widget.prefs,)));
      //   return;
      // }
      // var snackBar = SnackBar(
      // content: Text(data['message']),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  bool isValidEmail(String email) {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
    }
  bool isValidPhone(String phone) {
      return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }
  bool isValidUpi(String upi) {
      return RegExp(r'([a-zA-Z0-9.-]{2,256}[@][a-zA-Z]{2,64})').hasMatch(upi);
  }
}
