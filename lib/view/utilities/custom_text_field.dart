import 'package:flutter/material.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/app_color.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/textstyle.dart';

class customTextField extends StatefulWidget {
  String label;
  bool ispassword;
  bool isobsure;
  TextEditingController controller;
  TextInputType keyboardType;
  final String error;
  final FocusNode? focusNode;
  bool? isFocused;
  final errorCondition;

  customTextField(
      {super.key,
        this.keyboardType = TextInputType.text,
        required this.controller,
        this.ispassword = false,
        this.isobsure = false,
        required this.label,
        required this.error,
        this.isFocused = false,
        this.errorCondition,
        this.focusNode});

  @override
  State<customTextField> createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
            Border.all(color: widget.errorCondition ? Colors.red : Theme.of(context).brightness == Brightness.dark
                  ? kWhite
                  : kBlack),

          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: TextField(
                focusNode: widget.focusNode,
                onChanged: (_) {
                  setState(() {
                    widget.isFocused = false;
                  });
                },
                keyboardType: widget.keyboardType,
                obscureText: widget.isobsure,
                controller: widget.controller,
                decoration: InputDecoration(
                    hintText: widget.label,
                    suffixIcon: widget.ispassword
                        ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.isobsure = !widget.isobsure;
                          });
                        },
                        icon: Icon(
                            widget.isobsure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            //color: grey5,
                            size: 15))
                        : null,
                    hintStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(20)),
              ),
            ),
          ),
        ),
        if (widget.errorCondition)
          Text(
            widget.error,
            style: body4(Colors.red, TextDecoration.none),
          )
      ],
    );
  }
}