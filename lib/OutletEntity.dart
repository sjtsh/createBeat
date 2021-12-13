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
  final String ownersNumber;
  final String formattedAddress;
  final String address;
  final String subCity;
  final String market;
  final String city;
  final String state;
  final String img;

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
    this.formattedAddress,
    this.address,
    this.subCity,
    this.market,
    this.city,
    this.state,
    this.img,
  );

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      json["id"],
      json["zone"],
      json['region'],
      json['territory'],
      json['beatsName'],
      json['beatsERPID'],
      json['distributor'],
      json['outletERPID'],
      json['outletsName'],
      json['lat'],
      json['lng'],
      json['ownersName'],
      json['ownersNumber'],
      json['formattedAddress'],
      json['address'],
      json['subCity'],
      json['market'],
      json['city'],
      json['state'],
      json['img'],
    );
  }
}
