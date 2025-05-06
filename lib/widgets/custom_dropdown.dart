import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownItem {
  final int value;
  final String text;

  const CustomDropdownItem({required this.value, required this.text });
}

class CustomDropdown extends StatelessWidget {
  final List<CustomDropdownItem> items;
  final int? value;
  final double? width;
  final void Function(int? value)? onChanged;
  const CustomDropdown({super.key, required this.items, this.value,this.onChanged, this.width});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: value,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          padding: EdgeInsets.zero,

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: .5, color: Colors.black.withValues(alpha: .5)),
            borderRadius: BorderRadius.circular(3),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(0, 2))],
          ),
        ),
        buttonStyleData: ButtonStyleData(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .7),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(width: .5, color: Colors.black.withValues(alpha: .5)),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 35,

          selectedMenuItemBuilder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                border: Border.symmetric(vertical: BorderSide(color: Colors.black.withValues(alpha: .5), width: .5)),
              ),
              child: child,
            );
          },
        ),
        items:
            items
                .map(
                  (e) => DropdownMenuItem(

                    value: e.value,
                    child: Text(
                      e.text,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                )
                .toList(),
        onChanged: onChanged,

        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
