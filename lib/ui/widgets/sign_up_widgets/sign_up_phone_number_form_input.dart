import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPhoneNumberFormInput extends StatelessWidget {
  const SignUpPhoneNumberFormInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Phone number'),
          Stack(
            children: [
              const Positioned(
                left: 12,
                top: 14,
                child: Text(
                  '+998',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: controller,
                inputFormatters: [LengthLimitingTextInputFormatter(9)],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(60, 10, 20, 10),
                  hintText: '(__) ___ - __ - __',
                  hintStyle: const TextStyle(color: Color(0xFF949CA9)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
