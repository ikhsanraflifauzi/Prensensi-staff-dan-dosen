import 'package:flutter/material.dart';

import '../../../Utils/Colors.dart';

class HeaderFoto extends StatelessWidget {
  const HeaderFoto({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      child: Stack(children: <Widget>[
        Container(
          height: size.height * 0.2 - 25,
          decoration: BoxDecoration(
            color: ColorConstants.darkClearBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Center(
          child: Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipOval(
              child: Container(
                width: 125,
                height: 125,
                child: Image.asset(
                  'Assets/image/Ikhsan.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
