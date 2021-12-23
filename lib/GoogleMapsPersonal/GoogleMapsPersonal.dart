import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../data.dart';

class GoogleMapsPersonal extends StatelessWidget {
  final PanelController _panelController;
  final List<Marker> markers;
  final Function _onMapCreated;
  final Function refresh;
  final bool isHeader;
  final Function setHeader;
  final Set<Polyline> polylines;

  GoogleMapsPersonal(
      this._panelController, this.markers, this._onMapCreated, this.refresh, this.polylines, this.isHeader, this.setHeader);

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
              Marker(
                  markerId: MarkerId("markerId"),
                  position: LatLng(
                    27.650136,
                    85.337996,
                  ),
                  onTap: () {
                    _panelController.animatePanelToPosition(0.5);
                  })
              // ...markers.where((element) => Polyline(
              //     polylineId: PolylineId("1"),
              //     points: starvaCoordinates,
              //     visible: true,
              //     color: Colors.blue,width: 10).),
              // Marker(
              //     markerId: MarkerId("test"),
              //     position: LatLng(myLat, myLng))
            },
            // onLongPress: _addMarker,
            // myLocationEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // onTap: ,
            polylines: polylines,
          ),
        ),
        Positioned(
          left: 2,
          top: 45,
          child: GestureDetector(
            onTap: () {
            setHeader(!isHeader);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                    )
                  ],
                  border: Border.all(
                    color: Colors.black.withOpacity(0.3),
                    width: 0.7,
                  ),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isHeader ? Icons.arrow_upward_rounded:Icons.arrow_downward_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
