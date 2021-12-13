import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';

class BeatsPolyline {
  final String name;
  List<LatLng> LatLon = [];

  BeatsPolyline(this.name);
}

/// Generating GPX Data from file

Future<BeatsPolyline> fileData(String string) async {
  var xmlGpx = GpxReader().fromString(string);

  //List<LatLng> LatLon = [];
  String name = "";
  BeatsPolyline beatsPolyline = BeatsPolyline(xmlGpx.trks[0].name ?? "");

  for (var i in xmlGpx.trks) {
    for (var j in i.trksegs) {
      for (var k in j.trkpts) {
        beatsPolyline.LatLon.add(LatLng(k.lat!, k.lon!));
      }
    }
  }
  return beatsPolyline;
}
