import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data.dart';

class GoogleMapsPersonal extends StatelessWidget {
  final String beatName;
  final List<Marker> markers;
  final bool isAll;
  final Function _onMapCreated;
  final Function removeBeat;
  final Function changeAll;
  final Function refresh;

  GoogleMapsPersonal(this.beatName, this.markers, this.isAll, this._onMapCreated, this.removeBeat, this.changeAll, this.refresh);

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
              tilt: 50,
            ),
            onMapCreated: (GoogleMapController _controller) {
              _onMapCreated(_controller);
            },
            markers: {
              ...markers
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
            polylines: {
              Polyline(
                  polylineId: PolylineId("1"),
                  points: starvaCoordinates,
                  visible: true,
                  color: Colors.blue,
                  width: 10),
              Polyline(
                  polylineId: PolylineId("1"),
                  points: starvaCoordinates,
                  visible: true,
                  color: Colors.blue,
                  width: 10),
            },
          ),
        ),
        Positioned(
          top: 50,
          right: 2,
          child: GestureDetector(
            onTap: () {
              removeBeat();
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
                  color: beatName == "" ? Colors.green : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.all_out_sharp,
                  color: beatName == "" ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 95,
          right: 2,
          child: GestureDetector(
            onTap: () {
              changeAll(!isAll);
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
                  color: isAll ? Colors.green : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                        Icons.add_location,
                        color: isAll ? Colors.white : Colors.black,
                      ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 2,
          top: 45,
          child: GestureDetector(
            onTap: () {
            refresh();
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
                child: const Icon(
                        Icons.refresh,
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
