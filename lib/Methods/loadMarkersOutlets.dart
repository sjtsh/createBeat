import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../OutletEntity.dart';
import '../data.dart';

var _markers;
var nearestOutlets;
var value;

loadMarkerOutlets(
    String searchBarInput,
    String beatName,
    Function changeBeatName,
    String distributorName,
    bool isAll,
    double radius) async {
  return Geolocator.getCurrentPosition().then((value) {
    if (searchBarInput != "") {
      List<Outlet> nearestOutlets = [];
      List<Marker> markers = [];
      for (int i = 0; i < allOutlets.length; i++) {
        bool isNear = false;
        for (var element in starvaCoordinates) {
          if (Geolocator.distanceBetween(allOutlets[i].lat, allOutlets[i].lng,
                  element.latitude, element.longitude) <
              20) {
            isNear = true;
          }
        }
        if (searchBarInput.toLowerCase() ==
                allOutlets[i]
                    .outletsName
                    .substring(0, searchBarInput.length)
                    .toLowerCase() ||
            searchBarInput.toLowerCase() ==
                allOutlets[i]
                    .beatsName
                    .substring(0, searchBarInput.length)
                    .toLowerCase()) {
          nearestOutlets.add(allOutlets[i]);
          if (isNear) {
            markers.add(
              Marker(
                markerId: MarkerId("${allOutlets[i].id}"),
                infoWindow: InfoWindow(
                  title:
                      "${allOutlets[i].outletsName}- ${allOutlets[i].beatsName}",
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
                position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
                onTap: () {
                  changeBeatName(allOutlets[i]);
                },
              ),
            );
          } else {
            markers.add(
              Marker(
                markerId: MarkerId("${allOutlets[i].id}"),
                infoWindow: InfoWindow(
                  title:
                      "${allOutlets[i].outletsName}- ${allOutlets[i].beatsName}",
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue,
                ),
                position: LatLng(allOutlets[i].lat, allOutlets[i].lng,),
                onTap: () {
                  changeBeatName(allOutlets[i]);
                },
              ),
            );
          }
        }

      }
      return [markers, nearestOutlets, value];
    } else {
      if (beatName == "") {
        List<Outlet> nearestOutlets = [];
        List<Marker> markers = [];

        for (int i = 0; i < allOutlets.length; i++) {
          bool isNear = false;
          for (var element in starvaCoordinates) {
            if (Geolocator.distanceBetween(allOutlets[i].lat, allOutlets[i].lng,
                    element.latitude, element.longitude) >
                20) {
              isNear = true;
            }
          }
          double myLat = value.latitude;
          double myLng = value.longitude;
          if (isAll ||
              GeolocatorPlatform.instance.distanceBetween(
                      myLat, myLng, allOutlets[i].lat, allOutlets[i].lng) <
                  radius) {
            if (isNear) {
              markers.add(
                Marker(
                  markerId: MarkerId("${allOutlets[i].id}"),
                  infoWindow: InfoWindow(
                    title:
                        "${allOutlets[i].outletsName}- ${allOutlets[i].beatsName}",
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                  position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
                  onTap: () {
                    print("$i has been tapped");

                    changeBeatName(allOutlets[i]);
                  },
                ),
              );
            } else {
              markers.add(
                Marker(
                  markerId: MarkerId("${allOutlets[i].id}"),
                  infoWindow: InfoWindow(
                    title:
                        "${allOutlets[i].outletsName}- ${allOutlets[i].beatsName}",
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                  position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
                  onTap: () {
                    print("$i has been tapped");

                    changeBeatName(allOutlets[i]);
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
      } else {
        List<Outlet> beatOutlets = [];
        List<Marker> markers = [];
        for (int i = 0; i < allOutlets.length; i++) {
          bool isNear = false;
          for (var element in starvaCoordinates) {
            if (Geolocator.distanceBetween(allOutlets[i].lat, allOutlets[i].lng,
                    element.latitude, element.longitude) <
                20) {
              isNear = true;
            }
          }
          if (isAll || beatName == allOutlets[i].beatsName) {
            if (isNear) {
              markers.add(
                Marker(
                  markerId: MarkerId("$i"),
                  infoWindow: InfoWindow(
                    title:
                        "${allOutlets[i].outletsName}- ${allOutlets[i].beatsName}",
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                  position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
                  onTap: () {
                    print("$i has been tapped");

                    changeBeatName(allOutlets[i]);
                  },
                ),
              );
            } else {
              markers.add(
                Marker(
                  markerId: MarkerId("$i"),
                  infoWindow: InfoWindow(
                    title:
                        "${allOutlets[i].outletsName}- ${allOutlets[i].beatsName}",
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                  position: LatLng(allOutlets[i].lat, allOutlets[i].lng),
                  onTap: () {
                    print("$i has been tapped");

                    changeBeatName(allOutlets[i]);
                  },
                ),
              );
            }
          }
          if (beatName == allOutlets[i].beatsName) {
            beatOutlets.add(allOutlets[i]);
          }
        }
        print("isAllDisabled is set to false");
        return [markers, beatOutlets, value];
      }
    }
  });
}

