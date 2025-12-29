import 'package:flutter/material.dart';

class BaseDateTimePicker<T> extends StatelessWidget {
  const BaseDateTimePicker({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
  });
  final List<T> items;
  final T selected;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 36.0;
    final ScrollController _controller = ScrollController(
      initialScrollOffset: (items.indexOf(selected) * itemHeight),
    );

    _controller.addListener(() {
      final double offset = _controller.offset;
      final int index =
          ((offset + itemHeight / 2) / itemHeight)
              .floor(); 
      if (index >= 0 && index < items.length && items[index] != selected) {
        onSelect(items[index]);
      }
    });

    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            controller: _controller,
            itemCount: items.length,
            padding: EdgeInsets.symmetric(vertical: 80 / 2 - itemHeight / 2),
            itemBuilder: (context, index) {
              final value = items[index];
              return Container(
                height: itemHeight,
                alignment: Alignment.center,
                child: Text(value.toString(), style: TextStyle(fontSize: 16)),
              );
            },
          ),
          IgnorePointer(
            child: Container(
              height: itemHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.withAlpha(130),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
