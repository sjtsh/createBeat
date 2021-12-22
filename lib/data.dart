import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Backend/Entity/Beat.dart';
import 'GpxFileRead/BeatsPolyline.dart';
import 'OutletEntity.dart';

List<Outlet> allOutlets = [];
int threadCount = 10;

List<String> allRegions = [];

List<String> headers = [
  "Zone",
  "Region",
  "Territory",
  "Beats Name",
  "Beats ERP ID",
  "Distributor",
  "Outlet ERP ID",
  "Outlets Name",
  "Latitude",
  "Longitude",
  "Owners Name",
  "Owners Number",
  "Formatted Address",
  "Address",
  "SubCity",
  "Market",
  "City",
  "State",
  "Image"
];

Set<Polyline> polylinesLocal = <BeatsPolyline>[]
    .map(
      (e) => Polyline(
          polylineId: PolylineId(e.name),
          points: e.LatLon,
          visible: true,
          color: colors[Random().nextInt(colors.length)],
          width: 10),
    )
    .toSet();

Polyline? polylineSelected;
List colors = [Colors.cyanAccent, Colors.red, Colors.blue, Colors.green, Colors.orange];
