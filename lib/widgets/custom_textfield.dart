import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  final bool noBorder;
  final TextAlign textAlign;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool isDouble;
  final bool isNumber;
  final int? maxLength;
  CustomTextField({
    super.key,
    this.label,
    this.controller,
    this.obscureText = false,
    this.noBorder = false,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.onTap,this.onChanged,
    this.isDouble = false,
     this.isNumber = false, this.maxLength
  });

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      focusNode: _focusNode,
      textAlign: textAlign,
      onTapOutside: (e) {
        _focusNode.unfocus();
      },
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        label: Text(label ?? '', style: TextStyle(color: Colors.grey.shade700)),
        filled: true,
        fillColor: Colors.white.withValues(alpha: .7),
        isDense: true,
        isCollapsed: noBorder,
        counterText: '',
        border: noBorder ? InputBorder.none : OutlineInputBorder(),
        enabledBorder:
            noBorder
                ? InputBorder.none
                : OutlineInputBorder(borderSide: BorderSide(width: .5, color: Colors.black.withValues(alpha: .5))),
        focusedBorder:
            noBorder
                ? InputBorder.none
                : OutlineInputBorder(borderSide: BorderSide(width: .7, color: Colors.blue.shade600)),

      ),
      keyboardType: isDouble || isNumber ?  TextInputType.numberWithOptions(decimal: true) : null,
      inputFormatters: [
        if (isDouble) DoubleInputFormatter(),
        if(isNumber) FilteringTextInputFormatter.digitsOnly
      ],
    );
  }
}


class DoubleInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Nếu chuỗi mới có nhiều hơn 1 dấu chấm, giữ nguyên giá trị cũ
    if (newValue.text.contains('.') &&
        newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
      return oldValue;
    }
    // Chỉ cho phép các ký tự hợp lệ: số và tối đa 1 dấu chấm
    if (RegExp(r'^\d*\.?\d*$').hasMatch(newValue.text)) {
      return newValue;
    }

    // Giữ nguyên giá trị cũ nếu không hợp lệ
    return oldValue;
  }
}