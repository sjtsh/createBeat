import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Entity/OutletEntity.dart';
import '../../data.dart';

List<Marker> loadMarkerOutlets(
    double radius,
    double greenRadius,
    Function changeOutlet,
    Polyline polylineSelected,
    Function setMarkerRed,
    Function setMarkerGreen) {
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
      if (allOutlets[i].isAssigned ?? false) {
        markers.add(
          Marker(
            markerId: MarkerId("${allOutlets[i].id}"),
            infoWindow: InfoWindow(
              title: allOutlets[i].outletsName.split(" ").first,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
            onTap: () {
              if (!Recieve.isChanged) {
                print("$i has been tapped");

                changeOutlet(allOutlets[i],
                    LatLng(allOutlets[i].lat, allOutlets[i].lng));
              } else {
                if (outletsForBeat.contains(allOutlets[i].id)) {
                  setMarkerRed(allOutlets[i].id);
                } else {
                  setMarkerGreen(allOutlets[i].id);
                }
              }
            },
          ),
        );
      } else {
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
                title: allOutlets[i].outletsName.split(" ").first,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
              position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
              onTap: () {
                if (!Recieve.isChanged) {
                  print("$i has been tapped");

                  changeOutlet(allOutlets[i],
                      LatLng(allOutlets[i].lat, allOutlets[i].lng));
                } else {
                  if (outletsForBeat.contains(allOutlets[i].id)) {
                    setMarkerRed(allOutlets[i].id);
                  } else {
                    setMarkerGreen(allOutlets[i].id);
                  }
                }
              },
            ),
          );
          if (!outletsForBeat.contains(allOutlets[i].id)) {
            outletsForBeat.add(allOutlets[i].id);
          }
        } else {
          markers.add(
            Marker(
              markerId: MarkerId("${allOutlets[i].id}"),
              infoWindow: InfoWindow(
                title: allOutlets[i].outletsName.split(" ").first,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
              onTap: () {
                if (!Recieve.isChanged) {
                  print("$i has been tapped");
                  changeOutlet(allOutlets[i],
                      LatLng(allOutlets[i].lat, allOutlets[i].lng));
                } else {
                  if (outletsForBeat.contains(allOutlets[i].id)) {
                    setMarkerRed(allOutlets[i].id);
                  } else {
                    setMarkerGreen(allOutlets[i].id);
                  }
                }
              },
            ),
          );
        }
      }
    }
  }
  return markers;
}
