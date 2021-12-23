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
import 'package:nearestbeats/data.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Backend/Methods/loadMarkersOutlets.dart';
import 'OutletEntity.dart';

class MyHomePage extends StatefulWidget {
  final List<File> dropdownFiles;
  final Set<Polyline> polylines;

  MyHomePage(this.dropdownFiles, this.polylines);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double radius = 50;
  double greenRadius = 50;
  GoogleMapController? _googleMapController;
  final PanelController _panelController = PanelController();
  Outlet? outlet;
  bool isAdded = false;
  bool isHeader = true;

  Polyline? polyline;

  setHeader(bool newValue) {
    setState(() {
      isHeader = newValue;
    });
  }

  @override
  void initState() {
    polyline = widget.polylines.toList()[0];
    // TODO: implement initState
    super.initState();
  }

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

  void changePolyline(String polylineID) {
    for(Polyline i in widget.polylines){
      if (polylineID == i.polylineId.value) {
        setState(() {
          polyline = i;
        });
        _googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(i.points[0].latitude,
                  i.points[0].longitude),
              zoom: 17,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            List snapshot = loadMarkerOutlets(radius, greenRadius, changeOutlet, polyline!);
            List<Marker> markers = snapshot[0];
            List<Outlet> outlets = snapshot[1];
            return SlidingUpPanel(
              controller: _panelController,
              maxHeight: 450,
              minHeight: 50,
              isDraggable: false,
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
                  isAdded,
                  setAdded,
                  _panelController),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isHeader
                      ? Container(
                          height: isHeader ? 180 : 0,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(1),
                                offset: Offset(0, -2),
                                blurRadius: 3,
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                          ),
                          child: Header(radius, outlets, changeRadius,
                              widget.dropdownFiles, widget.polylines, polyline!, greenRadius, changeGreenRadius, changePolyline, googleMapController: _googleMapController),
                        )
                      : Container(),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: GoogleMapsPersonal(
                          _panelController,
                          markers,
                          _onMapCreated,
                          widget.polylines,
                          isHeader,
                          setHeader)),
                ],
              ),
            );
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
        ),
      ),
    );
    _panelController.open();
    _googleMapController
        ?.showMarkerInfoWindow(MarkerId(newOutlet.id.toString()));
  }

  void changeRadius(newRadius) {
    setState(() {
      radius = newRadius;
    });
  }

  void changeGreenRadius(newRadius){
  setState(() {
    greenRadius = newRadius;
  });
  }
}
