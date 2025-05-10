import 'package:flutter/material.dart';

class WidgetSelectMien extends StatelessWidget {
  final Set<String> selected;
  final void Function(Set<String>)? onSelectionChanged;
  final Axis direction;
  const WidgetSelectMien({super.key, required this.selected, this.onSelectionChanged, this.direction = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      direction: direction,
      showSelectedIcon: false,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
      ),
      selectedIcon: null,
      onSelectionChanged: onSelectionChanged,
      segments: [
        ButtonSegment(value: 'Nam', label: Text('Nam',softWrap: false)),
        ButtonSegment(value: 'Trung', label: Text('Trung',softWrap: false,)),
        ButtonSegment(value: 'Bắc', label: Text('Bắc',softWrap: false)),
      ],

      selected: selected,
    );
  }
}
