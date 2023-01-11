import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  InputText({super.key,required this.controller,required this.variable,required this.name});
  TextEditingController controller;
  String variable;
  String name;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late String n;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    n = widget.name;
  }
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
            width: deviceWidth * .90,
            height: deviceWidth * .14,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: TextField(
                  cursorColor: Colors.grey,
                  onChanged: (text){
                    setState(() {
                      widget.variable = text;
                    });
                  },
                  controller: widget.controller,
                  style: TextStyle(
                    fontSize: deviceWidth * .040,
                  ),
                  decoration:  true ?  InputDecoration.collapsed(
                    hintText: widget.name,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )
                  ) : const InputDecoration(
                    errorText: 'Please Enter a valid Email'
                  ),
                ),
              ),
            ),
          );
  }
}