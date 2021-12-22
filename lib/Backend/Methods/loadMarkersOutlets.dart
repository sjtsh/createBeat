import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../OutletEntity.dart';
import '../../data.dart';

var _markers;
var nearestOutlets;
var value;

loadMarkerOutlets(double radius, Function changeOutlet) async {
  List<Outlet> nearestOutlets = [];
  List<Marker> markers = [];

  for (int i = 0; i < allOutlets.length; i++) {
    bool isNear = false;
    for (var element in polylineSelected!.points) {
      if (Geolocator.distanceBetween(allOutlets[i].lat, allOutlets[i].lng,
              element.latitude, element.longitude) <
          radius) {
        isNear = true;
      }
    }
    if (isNear) {
      markers.add(
        Marker(
          markerId: MarkerId("${allOutlets[i].id}"),
          infoWindow: InfoWindow(
            title: "${allOutlets[i].outletsName}",
            snippet: allOutlets[i].beatsName,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
          onTap: () {
            print("$i has been tapped");

            changeOutlet(allOutlets[i]);
          },
        ),
      );
    } else {
      if (allOutlets[i].isAssigned ?? false) {
        markers.add(
          Marker(
            markerId: MarkerId("${allOutlets[i].id}"),
            infoWindow: InfoWindow(
              title: "${allOutlets[i].outletsName}",
              snippet: allOutlets[i].beatsName,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
            onTap: () {
              print("$i has been tapped");

              changeOutlet(allOutlets[i]);
            },
          ),
        );
      } else {
        markers.add(
          Marker(
            markerId: MarkerId("${allOutlets[i].id}"),
            infoWindow: InfoWindow(
              title: "${allOutlets[i].outletsName}",
              snippet: allOutlets[i].beatsName,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
            onTap: () {
              print("$i has been tapped");

              changeOutlet(allOutlets[i]);
            },
          ),
        );
      }
    }
  }
  print(markers);
  return [markers, nearestOutlets, value];
}
