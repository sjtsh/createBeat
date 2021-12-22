import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey = '<YOUR-API-KEY>';
  final String pathParam = 'driving-car'; // Change it if you want
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  NetworkHelper(this.startLng, this.startLat, this.endLng, this.endLat);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(
        '$url$pathParam?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
