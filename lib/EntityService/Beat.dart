class Beat {
  final String beat;
  final String distributor;
  final String region;

  Beat(this.beat, this.distributor, this.region);

  factory Beat.fromJson(Map<String, dynamic> json) {
    return Beat(
      json["beatName"],
      json["distributorName"],
      json['regionName'],
    );
  }
}
