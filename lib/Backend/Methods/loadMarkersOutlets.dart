import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Entity/OutletEntity.dart';
import '../../data.dart';


List<Marker> loadMarkerOutlets(double radius, double greenRadius, Function changeOutlet,
    Polyline polylineSelected) {
  outletsForBeat = [];
  List<Marker> markers = [];
  for (int i = 0; i < allOutlets.length; i++) {
    bool radiiNear = false;
    for (var element in polylineSelected.points) {
      if (Geolocator.distanceBetween(allOutlets[i].lat, allOutlets[i].lng,
          element.latitude, element.longitude) <
          radius) {
        radiiNear = true;
      }
    }
    if (radiiNear) {
      bool isNear = false;
      for (var element in polylineSelected.points) {
        if (Geolocator.distanceBetween(allOutlets[i].lat, allOutlets[i].lng,
            element.latitude, element.longitude) <
            greenRadius) {
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

                changeOutlet(allOutlets[i],  LatLng(allOutlets[i].lat, allOutlets[i].lng));
              },
            ),
        );
        outletsForBeat.add(allOutlets[i].id);
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

                changeOutlet(allOutlets[i],  LatLng(allOutlets[i].lat, allOutlets[i].lng));
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

                changeOutlet(allOutlets[i],  LatLng(allOutlets[i].lat, allOutlets[i].lng));
              },
            ),
          );
        }
      }
    }
  }
  return markers;
}
