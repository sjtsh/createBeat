import 'package:google_maps_flutter/google_maps_flutter.dart';

class Outlet {
  int id;
  String zone;
  String region;
  String territory;
  String beatsName;
  String beatsERPID;
  String distributor;
  String outletERPID;
  String outletsName;
  double lat;
  double lng;
  String ownersName;
  int ownersNumber;
  String type;
  String formattedAddress;
  String address;
  String subCity;
  String market;
  String city;
  String state;
  String img;
  String remarks;
  String? newBeat;
  bool? isAssigned;
  String? newDistributor;

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
      this.isAssigned, this.newDistributor});

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
      newDistributor: json['24'],
      isAssigned: json['23'] == null
          ? null
          : json['23'] == 0
              ? false
              : true,
    );
  }
}
