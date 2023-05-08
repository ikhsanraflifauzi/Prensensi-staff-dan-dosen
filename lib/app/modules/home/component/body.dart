import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/home/component/isiText.dart';

class BodyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 24,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
            ),
            child: ClipOval(
              child: Container(
                width: 50,
                height: 50,
                child: Image.asset(
                  'Assets/image/Ikhsan.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                'Ikhsan Rafli Fauzi',
                style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'jl.Cipmai desa citeko',
                style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 15,
                    fontWeight: FontWeight.w100),
              ),
            ],
          )
        ],
      ),
      SizedBox(
        height: 82,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 175,
        decoration: BoxDecoration(
            color: ColorConstants.lightClearBlue,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 5,
            ),
            Center(
                child: Text(
              'Presensi',
              style: TextStyle(
                  fontFamily: 'Lexend', fontSize: 14, color: Colors.white),
            )),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DataText(name: 'Hari/Tanggal', value: 'senin, 08/03/2023'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DataText(name: 'Status', value: 'Masuk'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DataText(name: 'Jam Masuk', value: '08 : 00'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DataText(name: 'Jam pulang', value: '17 : 00'),
            ),
          ],
        ),
      )
    ]);
  }
}
