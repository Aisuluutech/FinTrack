import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    this.label,
    required this.onChanged,
    this.hintText,
    required this.keyboardType,
    this.maxLines,
    this.controller,


  });
  final String? label;
  final void Function(String) onChanged;
  final String? hintText;
  final TextInputType keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      onChanged: onChanged, 
      keyboardType: keyboardType,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText, 
        label: label == null ? null : Text(label!, style: Theme.of(context).textTheme.bodyMedium,),
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
