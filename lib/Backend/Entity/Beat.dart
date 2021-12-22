class Beat {
  final String beat;
  final String distributor;
  final String region;
  final String beatERPID;

  Beat(this.beat, this.distributor, this.region, this.beatERPID);

  factory Beat.fromJson(Map<String, dynamic> json) {
    return Beat(
      json["beatName"],
      json["distributorName"],
      json['regionName'],
      json['beatERPID'],
    );
  }
}
