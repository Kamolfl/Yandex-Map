import 'package:flutter/material.dart';

class SignUpFormInput extends StatelessWidget {
  const SignUpFormInput({super.key, required this.title, required this.controller, required this.hintText});
  final String title;
  final TextEditingController  controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          TextFormField(
            controller: controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF949CA9)),
            ),
          ),
        ],
      ),
    );
  }
}
