import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';
import 'package:nearestbeats/HomePage.dart';
import 'package:nearestbeats/data.dart';

import 'ChooseScreen.dart';
import 'ExpandablePanel.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => SelectionScreenState();
}

class SelectionScreenState extends State<SelectionScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: BeatService().fetchBeats(context),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<String> myRegions = [];
              List<Beat> beats = snapshot.data;
              beats.forEach((element) {
                if (!myRegions.contains(element.region)) {
                  myRegions.add(element.region);
                }
              });
              return ChooseScreen(myRegions, beats);
            }
            return Center(
                child: Image.asset(
              "assets/logo.png",
            ));
          },
        ),
      ),
    );
  }
}
