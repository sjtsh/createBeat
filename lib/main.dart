import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearestbeats/ActivationScreen/ActivationScreen.dart';
import 'package:nearestbeats/ConfirmationScreen/confirmationScreen.dart';
import 'package:nearestbeats/GpxFileRead/GpxFileRead.dart';
import 'package:nearestbeats/NewUI/DistributorRegion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

import 'ActivationScreen.dart';
import 'Backend/Service/Auth.dart';
import 'HomePage.dart';
import 'Backend/Entity/OutletEntity.dart';

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

      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            SharedPreferences prefs = snapshot.data;
            int code = prefs.getInt("key") ?? 0;
            if (code == 0) {
              return ActivationScreen();
            } else {
              AuthService().checkLogIn(code).then(
                (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        if (value) {
                          return const GpxFileRead();
                        } else {
                          return ActivationScreen();
                        }
                      },
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Image.asset(
              "assets/logo.png",
            ),
          );
        },
      ),

    );
  }
}
