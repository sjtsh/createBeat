class Beat {
  final int beatID;
  final String beat;
  final String distributor;
  final String region;
  final String beatERPID;

  Beat(this.beatID,this.beat, this.distributor, this.region, this.beatERPID);

  factory Beat.fromJson(Map<String, dynamic> json) {
    return Beat(
      json["beatID"],
      json["beatName"],
      json["distributorName"],
      json['regionName'],
      json['beatERPID'],
    );
  }
}
