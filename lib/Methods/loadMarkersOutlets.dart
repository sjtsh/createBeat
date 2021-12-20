import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../OutletEntity.dart';
import '../data.dart';

var _markers;
var nearestOutlets;
var value;

loadMarkerOutlets(double radius, Function changeOutlet) async {
  return Geolocator.getCurrentPosition().then((value) {
    List<Outlet> nearestOutlets = [];
    List<Marker> markers = [];

    for (int i = 0; i < allOutlets.length; i++) {
      bool isNear = false;
      for (var a in polylinesLocal) {
        for (var element in a.points) {
          if (Geolocator.distanceBetween(allOutlets[i].lat, allOutlets[i].lng,
                  element.latitude, element.longitude) >
              20) {
            isNear = true;
          }
        }
      }
      double myLat = value.latitude;
      double myLng = value.longitude;
      if (GeolocatorPlatform.instance.distanceBetween(
              myLat, myLng, allOutlets[i].lat, allOutlets[i].lng) <
          radius) {
        if (isNear) {
          markers.add(
            Marker(
              markerId: MarkerId("${allOutlets[i].id}"),
              infoWindow: InfoWindow(
                title:
                "${allOutlets[i].outletsName}",
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
          markers.add(
            Marker(
              markerId: MarkerId("${allOutlets[i].id}"),
              infoWindow: InfoWindow(
                title:
                    "${allOutlets[i].outletsName}",
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
        }
      }

      if (GeolocatorPlatform.instance.distanceBetween(
              myLat, myLng, allOutlets[i].lat, allOutlets[i].lng) <
          radius) {
        nearestOutlets.add(allOutlets[i]);
      }
    }
    return [markers, nearestOutlets, value];
  });
}
