import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/OutletEntity.dart';
import 'package:nearestbeats/data.dart';

import 'multithreading.dart';

// Future<List> getBeatOutlets(Argument argument, String beatName) async {
//   List<Marker> markers = [];
//   List<Outlet> beatOutlets = [];
//   for (int i = argument.startPoint; i < argument.endPoint; i++) {
//     if (outlets[i].beatsName == beatName) {
//       beatOutlets.add(outlets[i]);
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
//     }
//   }
//
//   return [markers, beatOutlets];
// }
