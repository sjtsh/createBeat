import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/Backend/Entity/OutletEntity.dart';
import 'package:nearestbeats/Backend/Methods/loadMarkersOutlets.dart';
import 'package:nearestbeats/GoogleMapsPersonal/GoogleMapsPersonal.dart';
import 'package:nearestbeats/SlidingPanel/SlidingPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Header.dart';
import '../data.dart';

class MajorSlidingPanel extends StatefulWidget {
  final bool isAdded;
  final Function setAdded;
  final Polyline polyline;
  final double width;
  final bool isHeader;
  final Function _onMapCreated;
  final Function setHeader;
  final List<File> dropdownFiles;
  final Set<Polyline> polylines;
  final GoogleMapController? googleMapController;
  final Function changePolyline;
  final String distributorName;
  final String beatName;
  final List<String> multiFileColors;

  MajorSlidingPanel(
      this.isAdded,
      this.setAdded,
      this.polyline,
      this.width,
      this.isHeader,
      this._onMapCreated,
      this.setHeader,
      this.dropdownFiles,
      this.polylines,
      this.googleMapController,
      this.changePolyline,
      this.distributorName,
      this.beatName,
      this.multiFileColors);

  @override
  _MajorSlidingPanelState createState() => _MajorSlidingPanelState();
}

class _MajorSlidingPanelState extends State<MajorSlidingPanel> {
  List<Marker> markers = [];
  double radius = 1000;
  double greenRadius = 20;
  final PanelController _panelController = PanelController();
  Outlet? outlet;

  /// for panel

  bool isPanelOpen= false;

  setMarkerGreen(markerID) {
    for (int i = 0; i < markers.length; i++) {
      if (markers[i].markerId == MarkerId(markerID.toString())) {
        Marker marker = markers[i].copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        setState(() {
          markers.remove(markers[i]);
          markers.add(marker);
          if (!outletsForBeat.contains(markerID)) {
            outletsForBeat.add(markerID);
          }
          print(outletsForBeat);
        });
      }
    }
  }

  setMarkerRed(markerID) {
    for (int i = 0; i < markers.length; i++) {
      if (markers[i].markerId == MarkerId(markerID.toString())) {
        Outlet outlet =
            allOutlets.firstWhere((element) => element.id == markerID);
        Marker marker;
        if (outlet.isAssigned ?? false) {
          marker = markers[i].copyWith(
            iconParam: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          );
        } else {
          marker = markers[i].copyWith(
            iconParam: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          );
        }
        setState(() {
          markers.remove(markers[i]);
          markers.add(marker);
          outletsForBeat.remove(markerID);
          print(outletsForBeat);
        });
      }
    }
  }

  void changeOutlet(Outlet newOutlet, LatLng position) {
    setState(
      () {
        outlet = newOutlet;
      },
    );
    _panelController.open();
    widget.googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 17,
        ),
      ),
    );
    widget.googleMapController
        ?.showMarkerInfoWindow(MarkerId(newOutlet.id.toString()));
  }

  void changeRadius(newRadius) {
    setState(() {
      radius = newRadius;
      markers =
          loadMarkerOutlets(radius, greenRadius, changeOutlet, widget.polyline);
    });
  }

  void changeGreenRadius(newRadius) {
    setState(() {
      greenRadius = newRadius;
      markers =
          loadMarkerOutlets(radius, greenRadius, changeOutlet, widget.polyline);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    markers =
        loadMarkerOutlets(radius, greenRadius, changeOutlet, widget.polyline);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SlidingUpPanel(
      controller: _panelController,
      maxHeight: 350,
      minHeight: 35,
      isDraggable:false,
      panelSnapping: true,
      parallaxEnabled: true,
      color: Colors.transparent,
      panel: SlidingPanel(
          outlet ??
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
          widget.isAdded,
          widget.setAdded,
          widget.polyline,
          _panelController,
          setMarkerRed,
          setMarkerGreen),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: 50,
          ),
          GoogleMapsPersonal(
              _panelController,
              markers,
              widget._onMapCreated,
              widget.polylines,
              widget.isHeader,
              widget.setHeader,
              widget.distributorName,
              widget.beatName,
              setMarkerRed,
              changeRadius),
          Positioned(
              top: 12,

              child: Header(
                radius,
                changeRadius,
                widget.dropdownFiles,
                widget.polylines,
                widget.polyline,
                greenRadius,
                changeGreenRadius,
                widget.changePolyline,
                widget.distributorName,
                widget.beatName,
                setMarkerRed,
                context,
                widget.multiFileColors,

                googleMapController: widget.googleMapController,
              ))
        ],
      ),
    );
  }
}
