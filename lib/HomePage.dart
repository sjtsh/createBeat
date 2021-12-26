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
import 'package:nearestbeats/SlidingPanel/MajorSlidingPanel.dart';
import 'package:nearestbeats/SlidingPanel/SlidingPanel.dart';
import 'package:nearestbeats/data.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Backend/Methods/loadMarkersOutlets.dart';
import 'Backend/Entity/OutletEntity.dart';

class MyHomePage extends StatefulWidget {
  final List<File> dropdownFiles;
  final Set<Polyline> polylines;
  final String distributorName;

  MyHomePage(this.dropdownFiles, this.polylines, this.distributorName);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController? _googleMapController;
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
    Geolocator.getCurrentPosition().then((value) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng((polyline?.points[0].latitude) ?? value.latitude,
                (polyline?.points[0].longitude) ?? value.longitude),
            zoom: 17,
            tilt: 50,
          ),
        ),
      );
    });
  }

  void setAdded(bool newAdded) {
    setState(() {
      isAdded = newAdded;
    });
  }

  void changePolyline(String polylineID) {
    for (Polyline i in widget.polylines) {
      if (polylineID == i.polylineId.value) {
        setState(() {
          polyline = i;
        });
        _googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(i.points[0].latitude, i.points[0].longitude),
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
            return MajorSlidingPanel(
              isAdded,
              setAdded,
              polyline!,
              width,
              isHeader,
              _onMapCreated,
              setHeader,
              widget.dropdownFiles,
              widget.polylines,
              _googleMapController,
              changePolyline,
              widget.distributorName,
              (polyline?.polylineId.value) ?? "ananymous",
            );
          },
        ),
      ),
    );
  }
}
