import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/ConfirmScreen/ConfirmScreen.dart';
import 'package:nearestbeats/ConfirmationScreen/confirmationScreen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../data.dart';

class GoogleMapsPersonal extends StatelessWidget {
  final PanelController _panelController;
  final List<Marker> markers;
  final Function _onMapCreated;
  final bool isHeader;
  final Function setHeader;
  final Set<Polyline> polylines;
  final String distributorName;
  final String beatName;
  final Function setMarkerRed;
  final Function changeRadius;

  const GoogleMapsPersonal(
    this._panelController,
    this.markers,
    this._onMapCreated,
    this.polylines,
    this.isHeader,
    this.setHeader,
    this.distributorName,
    this.beatName,
    this.setMarkerRed,
    this.changeRadius,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
          height: height,
          child: GoogleMap(
            // myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                27.624917,
                85.347775,
              ),
              // target: LatLng(myLat, myLng),
              zoom: 17,
            ),
            onMapCreated: (GoogleMapController _controller) {
              _onMapCreated(_controller);
            },
            markers: {
              ...markers,
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            polylines: polylines,
          ),
        ),
      ],
    );
  }
}
