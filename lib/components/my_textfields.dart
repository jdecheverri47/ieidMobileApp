// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String hintText;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        autofocus: false,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.yellow.shade600
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        style: const TextStyle(
          fontSize: 14
        )
    );
  }
}