import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'OutletEntity.dart';
import 'data.dart';

class Header extends StatefulWidget {
  final double radius;
  final double width;
  final List<Outlet> outlets;
  final Function changeRadius;
  final List<File> dropdownFiles;
  final Set polylines;
  final Polyline polyline;
  GoogleMapController? googleMapController;


  Header(this.radius, this.width, this.outlets, this.changeRadius,
      this.dropdownFiles, this.polylines, this.polyline,
      {this.googleMapController});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
   String dropdownValue = "Select Distributor";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container()),
                Text("${widget.outlets.length} Outlets"),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
          Slider(
            onChangeEnd: (double value) {
              widget.changeRadius(value * 1000);
            },
            value: widget.radius > 1000 ? 1 : (widget.radius / 1000),
            onChanged: (double value) {},
            divisions: 10,
            activeColor: Colors.black.withOpacity(0.5),
            thumbColor: Colors.black,
            inactiveColor: Colors.black.withOpacity(0.1),
          ),
          DropdownSearch<String>(
            showClearButton: false,
            mode: Mode.MENU,
            selectedItem: widget.polyline.polylineId.value,
            showSelectedItems: true,
            items: List.generate(widget.polylines.length,
                (index) => widget.polylines.toList()[index].polylineId.value),
            hint: "Select Distributor",
            dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 8),
                fillColor: Color(0xffA0C7F4).withOpacity(0.1),
                filled: true,
                border: InputBorder.none),
            showSearchBox: true,
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: (input) {
              // setState(() {
              //   dropdownValue =
              //       input ?? "Select Distributor";
              // });
              widget.googleMapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(widget.polyline.points[0].latitude, widget.polyline.points[0].longitude),
                    zoom: 17,
                    tilt: 50,
                  ),
                ),
              );

            },
          ),
        ],
      ),
    );
  }
}
