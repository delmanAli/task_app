import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget defaultFormField({
  TextEditingController? controller,
  String? hint,
  String? titleText,
  required Function(String) onChanged,
  String? label,
  Widget? widget,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText ?? ''),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: TextFormField(
            onChanged: onChanged,
            readOnly: widget != null ? true : false,
            controller: controller,
            cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              suffixIcon: widget,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
