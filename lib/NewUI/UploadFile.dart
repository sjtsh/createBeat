// import 'package:flutter/material.dart';
// import 'package:nearestbeats/Backend/Entity/Beat.dart';
// import 'package:nearestbeats/Backend/Service/BeatService.dart';
// import 'package:nearestbeats/data.dart';
//
// import 'DistributorsList.dart';
//
// class UploadFile extends StatefulWidget {
//   const UploadFile({Key? key}) : super(key: key);
//
//   @override
//   _UploadFileState createState() => _UploadFileState();
// }
//
// class _UploadFileState extends State<UploadFile> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 35,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Icon(
//                               Icons.arrow_back,
//                             ),
//                           ),
//                           Expanded(child: Container()),
//                           const Text(
//                             "Select Distributor",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Expanded(child: Container())
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       "Upload Route Files",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w900,
//                         color: Color(0xff676767),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Expanded(child: Container()),
//                     Container(
//                       clipBehavior: Clip.hardEdge,
//                       height: 60,
//                       decoration: BoxDecoration(
//                           color: Color(0xff6C63FF),
//                           borderRadius: BorderRadius.circular(6)),
//                       child: MaterialButton(
//                         onPressed: () {
//                           print(checkedDetails);
//                           // Navigator.of(context)
//                           //     .push(MaterialPageRoute(builder: (context) {
//                           //   return DistributorRegion();
//                           // }));
//                         },
//                         child: Center(
//                           child: Text(
//                             "SELECT DISTRIBUTOR",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
