import 'dart:math';

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  const Logo({
    super.key,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: Text(
        "S",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
