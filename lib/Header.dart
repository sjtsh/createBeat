import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Backend/Entity/OutletEntity.dart';
import 'data.dart';

class Header extends StatefulWidget {
  final double radius;
  final Function changeRadius;
  final List<File> dropdownFiles;
  final Set polylines;
  final Polyline polyline;
  final GoogleMapController? googleMapController;
  final double greenRadius;
  final Function changeGreenRadius;
  final Function changePolyline;
  final distributorName ;

  Header(
      this.radius,
      this.changeRadius,
      this.dropdownFiles,
      this.polylines,
      this.polyline,
      this.greenRadius,
      this.changeGreenRadius,
      this.changePolyline,
      this.distributorName,
      {this.googleMapController});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String dropdownValue = "Select Distributor";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 12,
              ),
              Text(widget.distributorName),
              Expanded(child: Container(),),
              Text("${outletsForBeat.length} Outlets"),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        ),

        Slider(
          onChangeEnd: (double value) {
            widget.changeRadius(value * 3000);
          },
          value: widget.radius > 3000 ? 1 : (widget.radius / 3000),
          onChanged: (double value) {},
          divisions: 20,
          label: widget.radius.toString(),
          activeColor: Colors.red.withOpacity(0.5),
          thumbColor: Colors.red,
          inactiveColor: Colors.black.withOpacity(0.1),
        ),
        Slider(
          onChangeEnd: (double value) {
            widget.changeGreenRadius(value * 1000);
          },
          value: widget.greenRadius > 1000 ? 1 : (widget.greenRadius / 1000),
          onChanged: (double value) {},
          divisions: 10,
          label: widget.greenRadius.toString(),
          activeColor: Colors.green.withOpacity(0.5),
          thumbColor: Colors.green,
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
            widget.changePolyline(input);
          },
        ),
      ],
    );
  }
}
