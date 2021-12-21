// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:nearestbeats/Methods/multithreading.dart';
//
// import '../OutletEntity.dart';
// import '../data.dart';
//
// Future<List> getNearestOutlets(
//     Argument argument, int radius, Position value) async {
//   List<Marker> markers = [];
//   List<Outlet> nearestOutlets = [];
//   for (int i = argument.startPoint; i <= argument.endPoint; i++) {
//     double myLat = value.latitude;
//     double myLng = value.longitude;
//     if (GeolocatorPlatform.instance
//             .distanceBetween(myLat, myLng, outlets[i].lat, outlets[i].lng) <
//         radius) {
//
//       nearestOutlets.add(outlets[i]);
//       markers.add(
//         Marker(
//           markerId: MarkerId("$i"),
//           infoWindow: InfoWindow(
//             title: "${outlets[i].outletsName}- ${outlets[i].beatsName}",
//           ),
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueBlue,
//           ),
//           position: LatLng(outlets[i].lat, outlets[i].lng),
//         ),
//       );
//       print("found a outlet " + outlets[i].lat.toString() + " " + outlets[i].lng.toString());
//     }
//   }
//
//   return [markers, nearestOutlets];
// }
