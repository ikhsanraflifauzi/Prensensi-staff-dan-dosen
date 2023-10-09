// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          color: ColorConstants.darkClearBlue,
        )
      ],
    );
  }
}
