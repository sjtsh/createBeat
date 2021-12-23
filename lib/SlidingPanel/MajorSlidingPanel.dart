import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/Backend/Entity/OutletEntity.dart';
import 'package:nearestbeats/GoogleMapsPersonal/GoogleMapsPersonal.dart';
import 'package:nearestbeats/SlidingPanel/SlidingPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Header.dart';
import '../data.dart';

class MajorSlidingPanel extends StatefulWidget {
  final PanelController _panelController;
  final Outlet? outlet;
  final bool isAdded;
  final Function setAdded;
  final Polyline polyline;
  final double width;
  final bool isHeader;
  final List<Marker> markers;
  final Function _onMapCreated;
  final Function setHeader;
  final double radius;
  final Function changeRadius;
  final List<File> dropdownFiles;
  final Set<Polyline> polylines;
  final GoogleMapController? googleMapController;
  final double greenRadius;
  final Function changeGreenRadius;
  final Function changePolyline;
  final String distributorName;
  final Function changeOutlet;

  MajorSlidingPanel(
      this._panelController,
      this.outlet,
      this.isAdded,
      this.setAdded,
      this.polyline,
      this.width,
      this.isHeader,
      this.markers,
      this._onMapCreated,
      this.setHeader,
      this.radius,
      this.changeRadius,
      this.dropdownFiles,
      this.polylines,
      this.googleMapController,
      this.greenRadius,
      this.changeGreenRadius,
      this.changePolyline,
      this.distributorName,
      this.changeOutlet);

  @override
  _MajorSlidingPanelState createState() => _MajorSlidingPanelState();
}

class _MajorSlidingPanelState extends State<MajorSlidingPanel> {
  List<Marker>? markers;

  @override
  void initState() {
    // TODO: implement initState
    markers = widget.markers;
    super.initState();
  }

  setMarkerGreen(markerID) {
    for (int i = 0; i < markers!.length; i++) {
      if (markers![i].markerId == markerID) {
        Marker marker = Marker(
          markerId: MarkerId("$markerID"),
          infoWindow: InfoWindow(
            title: markers![i].infoWindow.title,
            snippet: markers![i].infoWindow.snippet,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          position: markers![i].position,
          onTap: () {
            print("$i has been tapped");

            widget.changeOutlet(allOutlets[i]);
          },
        );
        setState(() {
          markers?.remove(markers![i]);
          markers?.add(marker);
          outletsForBeat.add(markerID);
        });
      }
    }
  }

  setMarkerRed(markerID) {
    for (int i = 0; i < markers!.length; i++) {
      if (markers![i].markerId == markerID) {
        Marker marker = Marker(
          markerId: MarkerId("$markerID"),
          infoWindow: InfoWindow(
            title: markers![i].infoWindow.title,
            snippet: markers![i].infoWindow.snippet,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
          position: markers![i].position,
          onTap: () {
            print("$i has been tapped");

            widget.changeOutlet(allOutlets[i]);
          },
        );
        setState(() {
          markers?.remove(markers![i]);
          markers?.add(marker);
          outletsForBeat.remove(markerID);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: widget._panelController,
      maxHeight: 350,
      minHeight: 50,
      isDraggable: false,
      panelSnapping: true,
      parallaxEnabled: true,
      color: Colors.transparent,
      panel: SlidingPanel(
          widget.outlet ??
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
          widget._panelController),
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
                    widget.radius,
                    widget.changeRadius,
                    widget.dropdownFiles,
                    widget.polylines,
                    widget.polyline,
                    widget.greenRadius,
                    widget.changeGreenRadius,
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
              widget._panelController,
              markers!,
              widget._onMapCreated,
              widget.polylines,
              widget.isHeader,
              widget.setHeader,
            ),
          ),
        ],
      ),
    );
  }
}
