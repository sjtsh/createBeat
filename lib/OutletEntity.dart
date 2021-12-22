import 'package:google_maps_flutter/google_maps_flutter.dart';

class Outlet {
  final int id;
  final String zone;
  final String region;
  final String territory;
  final String beatsName;
  final String beatsERPID;
  final String distributor;
  final String outletERPID;
  final String outletsName;
  final double lat;
  final double lng;
  final String ownersName;
  final int ownersNumber;
  final String type;
  final String formattedAddress;
  final String address;
  final String subCity;
  final String market;
  final String city;
  final String state;
  final String img;
  final String remarks;
  String? newBeat;
  bool? isAssigned;

  Outlet(
      this.id,
      this.zone,
      this.region,
      this.territory,
      this.beatsName,
      this.beatsERPID,
      this.distributor,
      this.outletERPID,
      this.outletsName,
      this.lat,
      this.lng,
      this.ownersName,
      this.ownersNumber,
      this.type,
      this.formattedAddress,
      this.address,
      this.subCity,
      this.market,
      this.city,
      this.state,
      this.img,
      this.remarks,
      {this.newBeat,
      this.isAssigned});

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      json["0"],
      json["1"],
      json['2'],
      json['3'],
      json['4'],
      json['5'],
      json['6'],
      json['7'],
      json['8'],
      json['9'],
      json['10'],
      json['11'],
      json['12'],
      json['13'],
      json['14'],
      json['15'],
      json['16'],
      json['17'],
      json['18'],
      json['19'],
      json['20'],
      json['21'],
      newBeat: json['22'],
      isAssigned: json['23'] == null
          ? null
          : json['23'] == 0
              ? false
              : true,
    );
  }
}
