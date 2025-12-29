import 'package:flutter/material.dart';

class LabelRowWidget extends StatelessWidget {
  const LabelRowWidget({super.key, required this.label, required this.field});
  final String label;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label)),
        Expanded(child: Center(child: field)),
      ],
    );
  }
}
