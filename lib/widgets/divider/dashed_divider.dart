import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final int dash;
  final Color? color;
  const DashedDivider({Key? key, required this.dash, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: List.generate(
          dash,
          (index) => Container(
            color: index % 2 == 0 ? color ?? Colors.white : null,
            width: constraints.maxWidth / dash,
            height: 1,
          ),
        ),
      ),
    );
  }
}
