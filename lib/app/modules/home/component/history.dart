// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:protoype_t_a/app/modules/home/controllers/home_controller.dart';

// class lastFiveDay extends StatelessWidget {
//   const lastFiveDay({
//     super.key,
//     required this.controller,
//   });

//   final HomeController controller;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: controller.streamLastPresensi(),
//         builder: (context, snapPresnsi) {
//           if (snapPresnsi.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapPresnsi.data?.docs.length == 0 || snapPresnsi.data == null) {
//             return SizedBox(
//               height: 200,
//               child: Center(
//                 child: Text(
//                   'belum ada data presensi',
//                   style: TextStyle(fontFamily: 'Lexend', fontSize: 14),
//                 ),
//               ),
//             );
//           }
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: snapPresnsi.data!.docs.length,
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               if (snapPresnsi.hasData) {
//                 Map<String, dynamic>? data =
//                     snapPresnsi.data!.docs.reversed.toList()[index].data();
//                 return Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 15),
//                     width: 303,
//                     height: 113,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: [
//                         BoxShadow(
//                             offset: Offset(0, 7),
//                             blurRadius: 7,
//                             color: Colors.grey),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Column(children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Check in ',
//                               style: TextStyle(
//                                   fontFamily: 'Lexend',
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                                 '${DateFormat.yMMMEd().format(DateTime.parse(data["tanggal"]))}'),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               data['check in']?['tanggal'] == null
//                                   ? "-"
//                                   : '${DateFormat.Hms().format(DateTime.parse(data["check in"]!["tanggal"]))}',
//                               style: TextStyle(
//                                   fontFamily: 'Lexend',
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text('-'),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: const [
//                             Text(
//                               'Check Out',
//                               style: TextStyle(
//                                   fontFamily: 'Lexend',
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               data['check out']?['tanggal'] == null
//                                   ? "-"
//                                   : '${DateFormat.Hms().format(DateTime.parse(data["check out"]!["tanggal"]))}',
//                               style: TextStyle(
//                                   fontFamily: 'Lexend',
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ]),
//                     ),
//                   ),
//                 );
//               }
//             },
//           );
//         });
//   }
// }
