class Region {
  final int regionID;
  final String countryName;
  final String regionName;
  final bool deactivated;

  Region(this.regionID, this.countryName, this.regionName, this.deactivated);

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      json["regionID"],
      json["countryName"],
      json['regionName'],
      json['deactivated'],
    );
  }
}
