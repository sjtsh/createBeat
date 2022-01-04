import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Entity/OutletEntity.dart';
import '../Entity/Beat.dart';

class OutletService {
  Future<List<Outlet>> fetchOutlet(context, String region) async {
    int aStatusCode = 0;
    while (aStatusCode != 200) {
      try {
        final response = await http.post(
          Uri.parse(
              "https://asia-south1-hilifedb.cloudfunctions.net/getUnManagedOutlets"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              "region": region.toString(),
            },
          ),
        );
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          aStatusCode = 200;
          List<Outlet> outlets = values.map((e) => Outlet.fromJson(e)).toList();
          return outlets;

        } else {
          throw Exception("failed to load post, status code error");
        }
      } on SocketException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "No Internet Connection",
          textAlign: TextAlign.center,
        )));
        throw Exception("failed to load post");
      } on TimeoutException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sorry, Failed to Load Data",
                textAlign: TextAlign.center)));
        throw Exception("failed to load post");
      }
    }
    return [];
  }

  Future<bool> updateOutlet(
      context, Map<String, Map<String, String>> aBody) async {

    final response = await http.post(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/updateUnManagedOutlet"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(aBody),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to load post, status code error");
    }
  }
}
