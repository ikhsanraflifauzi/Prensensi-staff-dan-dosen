import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Riwayat_Presensi/Component/headerFoto.dart';

class BodyRiwayat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Column(
          children: <Widget>[
            HeaderFoto(size: size),
            Container(
              width: 304,
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                        color: Colors.grey)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Check in'), Text('masuk')],
              ),
            )
          ],
        ),
      ],
    );
  }
}
