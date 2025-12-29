import 'package:flutter/material.dart';

class BaseDropdownField<T> extends StatelessWidget {
  const BaseDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.hint,

  });

  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?) onChanged;
  final String? initialValue;
  final String? hint;
 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5)),
        ),
        value: value,
        style: Theme.of(context).textTheme.bodyMedium,
        icon: Icon(Icons.keyboard_arrow_down),
        hint: hint == null ? null : Text(hint!, style: Theme.of(context).textTheme.bodyLarge),
        items: items,
        onChanged: onChanged,
        
      ),
    );
  }
}
