import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nearestbeats/ActivationScreen/ActivationScreen.dart';
import 'package:nearestbeats/NewUI/futureDistributorRegion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Backend/Service/Auth.dart';


void main() {
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
                          return const FutureDistributorRegion();
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
