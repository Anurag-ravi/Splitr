import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splitr/models/usermodel.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:splitr/pages/homepage.dart';
import 'package:splitr/utilities/data.dart';
import 'package:http/http.dart' as http;
import 'package:splitr/utilities/functions.dart';
class OTPPage extends StatefulWidget {
  const OTPPage({super.key, required this.hash, required this.user});
  final String hash;
  final User user;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late OtpFieldController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = OtpFieldController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Center(
              child: Container(
                width: width * 0.7,
                child: const Text(
                  "Enter the OTP sent to your email",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            OTPTextField(
              length: 6,
              fieldWidth: width/9,
              style: const TextStyle(
                fontSize: 17
              ),
              controller: controller,
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin)async  {
                final response = await http.post(
                  Uri.parse("$baseUrl/auth/verify"),
                  headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json'
                  },
                  body: jsonEncode({
                    "email": widget.user.email,
                    "otp": pin,
                    "hash": widget.hash,
                  })
                );
                Map<String, dynamic> data = jsonDecode(response.body);
                if(data['status']==200){
                    showBar(data["message"],context);
                    print(data);
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => HomePage()));
                  } else {
                    showBar(data["message"],context);
                    controller.clear();
                  }
              },
            ),
          ],
        ),
      ),
    );
  }
}
