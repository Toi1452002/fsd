import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?)? onChanged;
  final bool enabled;
  const CustomCheckbox({super.key, required this.title, required this.value,required this.onChanged, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(child: Text(title,softWrap: false)),
          // Spacer(),
          SizedBox(width: 30,child: Checkbox(value: value, onChanged:enabled ? onChanged : null,))
        ],
      ),
    );
  }
}
