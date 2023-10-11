import 'package:flutter/material.dart';

Widget TextFieldWidget(String label, controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: 'Enter your $label',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
    ),
  )/*Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const ,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        maxLines: 1,
      ),
    ],
  )*/;
}