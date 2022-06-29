import 'package:flutter/material.dart';

class DashedDividerHorizontal extends StatelessWidget {
  final int dash;
  final Color? color;
  const DashedDividerHorizontal({Key? key, required this.dash, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: List.generate(
          dash,
          (index) => Container(
            color: index % 2 == 0 ? color ?? Colors.white : null,
            height: constraints.maxHeight / dash,
            width: 1,
          ),
        ),
      ),
    );
  }
}
