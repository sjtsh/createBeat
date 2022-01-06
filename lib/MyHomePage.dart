// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:nearestbeats/SlidingPanel/MajorSlidingPanel.dart';
//
// class MyHomePage extends StatefulWidget {
//   final List<File> dropdownFiles;
//   final Set<Polyline> polylines;
//   final String distributorName;
//   final List<String> multiFileColor;
//
//   MyHomePage(this.dropdownFiles, this.polylines, this.distributorName,
//       this.multiFileColor,);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   GoogleMapController? _googleMapController;
//   bool isAdded = false;
//   bool isHeader = true;
//
//   Polyline? polyline;
//
//   setHeader(bool newValue) {
//     setState(() {
//       isHeader = newValue;
//     });
//   }
//
//   @override
//   void initState() {
//     polyline = widget.polylines.toList()[0];
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _googleMapController?.dispose();
//     super.dispose();
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     _googleMapController = controller;
//     Geolocator.getCurrentPosition().then((value) {
//       controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng((polyline?.points[0].latitude) ?? value.latitude,
//                 (polyline?.points[0].longitude) ?? value.longitude),
//             zoom: 17,
//             tilt: 0,
//           ),
//         ),
//       );
//     });
//   }
//
//   void setAdded(bool newAdded) {
//     setState(() {
//       isAdded = newAdded;
//     });
//   }
//
//   void changePolyline(String polylineID) {
//     for (Polyline i in widget.polylines) {
//       if (polylineID == i.polylineId.value) {
//         setState(() {
//           polyline = i;
//         });
//         _googleMapController?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(i.points[0].latitude, i.points[0].longitude),
//               zoom: 17,
//             ),
//           ),
//         );
//       }
//     }
//   }
//   Future<bool> _onWillPop() {
//     // showDialog(
//     //   context: context,
//     //   builder: (context) => new AlertDialog(
//     //     title: new Text('Are you sure?'),
//     //     content: new Text('Do you want to exit an App'),
//     //     actions: <Widget>[
//     //       TextButton(
//     //         onPressed: () => Navigator.of(context).pop(false),
//     //         child: new Text('No'),
//     //       ),
//     //       TextButton(
//     //         onPressed: () => Navigator.of(context).pop(true),
//     //         child: new Text('Yes'),
//     //       ),
//     //     ],
//     //   ),
//     // );
//     print("hello");
//     return Future.value(false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: WillPopScope(
//         onWillPop:
//           _onWillPop,
//         child: Scaffold(
//           body: Builder(
//             builder: (context) {
//               return MajorSlidingPanel(
//                   isAdded,
//                   setAdded,
//                   polyline!,
//                   width,
//                   isHeader,
//                   _onMapCreated,
//                   setHeader,
//                   widget.dropdownFiles,
//                   widget.polylines,
//                   _googleMapController,
//                   changePolyline,
//                   widget.distributorName,
//                   (polyline?.polylineId.value) ?? "ananymous",
//                   widget.multiFileColor,);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
