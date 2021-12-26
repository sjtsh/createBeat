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
      this.distributorName,this.beatName);

  @override
  _MajorSlidingPanelState createState() => _MajorSlidingPanelState();
}

class _MajorSlidingPanelState extends State<MajorSlidingPanel> {
  List<Marker> markers = [];
  double radius = 1000;
  double greenRadius = 20;
  final PanelController _panelController = PanelController();
  Outlet? outlet;

  setMarkerGreen(markerID) {
    for (int i = 0; i < markers.length; i++) {
      if (markers[i].markerId == MarkerId(markerID.toString())) {
        Marker marker = Marker(
          markerId: MarkerId("$markerID"),
          infoWindow: InfoWindow(
            title: markers[i].infoWindow.title,
            snippet: markers[i].infoWindow.snippet,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          position: markers[i].position,
          onTap: () {
            changeOutlet(allOutlets[i], markers[i].position);
          },
        );
        setState(() {
          markers.remove(markers[i]);
          markers.add(marker);
          outletsForBeat.add(markerID);
          print(outletsForBeat);
        });
      }
    }
  }

  setMarkerRed(markerID) {
    for (int i = 0; i < markers.length; i++) {
      if (markers[i].markerId == MarkerId(markerID.toString())) {
        Marker marker = Marker(
          markerId: MarkerId("$markerID"),
          infoWindow: InfoWindow(
            title: markers[i].infoWindow.title,
            snippet: markers[i].infoWindow.snippet,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
          position: markers[i].position,
          onTap: () {
            changeOutlet(allOutlets[i], markers[i].position);
          },
        );
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
          target: LatLng(newOutlet.lat, newOutlet.lng),
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
      markers = loadMarkerOutlets(
          radius, greenRadius, changeOutlet, widget.polyline);
    });
  }

  void changeGreenRadius(newRadius) {
    setState(() {
      greenRadius = newRadius;
      markers = loadMarkerOutlets(
          radius, greenRadius, changeOutlet, widget.polyline);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    markers = loadMarkerOutlets(
        radius, greenRadius, changeOutlet, widget.polyline);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _panelController,
      maxHeight: 280,
      minHeight: 50,
      isDraggable: false,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.isHeader ? 180 : 40,
            width: widget.width,
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
            child: widget.isHeader
                ? Header(
                    radius,
                    changeRadius,
                    widget.dropdownFiles,
                    widget.polylines,
                    widget.polyline,
                    greenRadius,
                    changeGreenRadius,
                    widget.changePolyline,
                    widget.distributorName,
                    googleMapController: widget.googleMapController)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Text(widget.distributorName),
                      Expanded(
                        child: Container(),
                      ),
                      Text("${outletsForBeat.length} Outlets"),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            width: 50,
          ),
          Expanded(
            child: GoogleMapsPersonal(
              _panelController,
              markers,
              widget._onMapCreated,
              widget.polylines,
              widget.isHeader,
              widget.setHeader,
              widget.distributorName,
              widget.beatName,
                setMarkerRed,
            ),
          ),
        ],
      ),
    );
  }
}
