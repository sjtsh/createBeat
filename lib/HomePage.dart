import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nearestbeats/GoogleMapsPersonal/GoogleMapsPersonal.dart';
import 'package:nearestbeats/GoogleMapsPersonal/GoogleMapsSkeleton.dart';
import 'package:nearestbeats/Header.dart';
import 'package:nearestbeats/SlidingPanel/SlidingPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Backend/Methods/loadMarkersOutlets.dart';
import 'OutletEntity.dart';

class MyHomePage extends StatefulWidget {
  final List<File> dropdownFiles;

  MyHomePage(this.dropdownFiles);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double radius = 100;
  GoogleMapController? _googleMapController;
  final PanelController _panelController = PanelController();
  Outlet? outlet;
  bool isAdded = false;

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    // Geolocator.getCurrentPosition().then((value) {
    //   controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         target: LatLng(value.latitude, value.longitude),
    //         zoom: 17,
    //         tilt: 50,
    //       ),
    //     ),
    //   );
    // });
  }

  void setAdded(bool newAdded) {
    setState(() {
      isAdded = newAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadMarkerOutlets(radius, changeOutlet),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Marker> markers = snapshot.data[0];
              List<Outlet> outlets = snapshot.data[1];
              Position myPosition = snapshot.data[2];
              // double myLat = 27.725896;
              // double myLng = 85.343256;
              outlets.sort(
                (a, b) => GeolocatorPlatform.instance
                    .distanceBetween(
                        myPosition.latitude, myPosition.longitude, a.lat, a.lng)
                    // myLat,
                    // myLng,
                    // a.lat,
                    // a.lng)
                    .compareTo(
                      GeolocatorPlatform.instance.distanceBetween(
                          myPosition.latitude,
                          myPosition.longitude,
                          // myLat,
                          // myLng,
                          b.lat,
                          b.lng),
                    ),
              );
              return SlidingUpPanel(
                controller: _panelController,
                maxHeight: 400,
                minHeight: 50,
                isDraggable: true,
                panelSnapping: true,
                parallaxEnabled: true,
                color: Colors.transparent,
                panel: SlidingPanel(
                  Outlet(
                    3,
                    "zone",
                    "region",
                    "territory",
                    "beatsName",
                    "beatsERPID",
                    "distributor",
                    "outletERPID",
                    "outletsName",
                    27.650136,
                    85.337996,
                    "ownersName",
                    1,
                    "type",
                    "formattedAddress",
                    "address",
                    "subCity",
                    "market",
                    "city",
                    "state",
                    "img",
                    "",
                  ),
                  myPosition,
                  isAdded,
                  setAdded,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(radius, width, outlets, changeRadius, widget.dropdownFiles),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                        child: GoogleMapsPersonal(
                            _panelController, markers, _onMapCreated, refresh)),
                  ],
                ),
              );
            }
            return const GoogleMapsSkeleton();
          },
        ),
      ),
    );
  }

  void changeOutlet(Outlet newOutlet) {
    setState(
      () {
        outlet = newOutlet;
      },
    );
    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(newOutlet.lat, newOutlet.lng),
          zoom: 17,
          tilt: 50,
        ),
      ),
    );
    _panelController.animatePanelToPosition(1,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    _googleMapController
        ?.showMarkerInfoWindow(MarkerId(newOutlet.id.toString()));
  }

  void refresh() {
    setState(() {
      radius += 1;
      radius -= 1;
    });
  }

  void changeRadius(newRadius) {
    setState(() {
      radius = newRadius;
    });
  }
}
