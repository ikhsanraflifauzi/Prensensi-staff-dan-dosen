import 'package:flutter/material.dart';

class DataText extends StatelessWidget {
  final String name;
  final String value;

  const DataText({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: '$name : ',
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lexend'),
          children: [
            TextSpan(
              text: '$value ',
              style: const TextStyle(
                  fontSize: 14, color: Colors.white, fontFamily: 'Lexend'),
            )
          ]),
    );
  }
}
