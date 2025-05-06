import 'package:flutter/material.dart';
import 'package:fsd/data/data.dart';
import 'package:fsd/widgets/custom_textfield.dart';

CustomTextField buildTextFieldTable({required String text, void Function(String)? onChanged}){
  return CustomTextField(
    noBorder: true,
    isDouble: true,
    textAlign: TextAlign.center,
    controller: TextEditingController(text: text),
    onChanged: onChanged,
  );
}

