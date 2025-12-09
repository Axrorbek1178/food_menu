import 'package:flutter/material.dart';

class CustomCart extends StatelessWidget {
  final Widget child;
  final String number;
  const CustomCart({super.key, required this.child, required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        child,
        Positioned(
          top: 15,
          right: 10,
          child: Container(
            alignment: .center,
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(number, style: const TextStyle(fontSize: 8)),
          ),
        ),
      ],
    );
  }
}
