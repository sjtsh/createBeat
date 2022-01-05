import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsSkeleton extends StatelessWidget {
  const GoogleMapsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      // myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(27.672107, 85.428232),
        zoom: 17,
        tilt: 0

      ),
      markers: {},
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      // onLongPress: _addMarker,
      // myLocationEnabled: true,
    );
  }
}
