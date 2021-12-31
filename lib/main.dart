import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearestbeats/ActivationScreen/ActivationScreen.dart';
import 'package:nearestbeats/ConfirmationScreen/confirmationScreen.dart';
import 'package:nearestbeats/GpxFileRead/GpxFileRead.dart';
import 'package:nearestbeats/NewUI/DistributorRegion.dart';

import 'package:sqflite/sqflite.dart';

import 'HomePage.dart';
import 'Backend/Entity/OutletEntity.dart';
import 'NewUI/DistributorList.dart';
import 'SelectionScreen/ChooseScreen.dart';
import 'data.dart';

void main() {
  // getDatabasesPath().then((value) => print(value));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Rubik'
      ),
      home: ActivationScreen(),
    );
  }
}
