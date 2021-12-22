
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nearestbeats/Backend/Entity/Region.dart';

class RegionService{

  Future<List<Region>> fetchRegions(context) async {
    int aStatusCode = 0;
    List<Region> regions = [];
    while (aStatusCode != 200) {
      try {
        final response = await http.get(Uri.parse("https://asia-south1-hilifedb.cloudfunctions.net/getBeats"));
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<Region> regions =
          values.map((e) => Region.fromJson(e)).toList();
          return regions;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No Internet Connection", textAlign: TextAlign.center),
        ));
        throw Exception("failed to load post");
      } on TimeoutException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text("Sorry, Failed to Load Data", textAlign: TextAlign.center),
        ));
        throw Exception("failed to load post");
      }
    }
    return regions;
  }
}