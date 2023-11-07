import 'package:flutter/material.dart';

class TopRightBottomBadge extends StatelessWidget {
  const TopRightBottomBadge({
    super.key,
    required this.child,
    required this.data,
    this.color,
  });

  final Widget child;
  final Object data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          left: 14,
          bottom: 12,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 239, 91, 46),
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              data.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                //fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
