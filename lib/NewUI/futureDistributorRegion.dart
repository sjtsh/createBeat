import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';

import 'DistributorRegion.dart';

class FutureDistributorRegion extends StatefulWidget {
  const FutureDistributorRegion({Key? key}) : super(key: key);

  @override
  _FutureDistributorRegionState createState() => _FutureDistributorRegionState();
}

class _FutureDistributorRegionState extends State<FutureDistributorRegion> {
  refresh() {
    setState(() {
      // dropdownValue = "Select Distributor";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: FutureBuilder(
          future: BeatService().fetchBeats(context).then((value) {
            return value;
          }),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<String> myRegions = [];
              List<String> myRegionsToDisplay=[];
              List<Beat> beats = snapshot.data;
              beats.forEach((element) {
                if (!myRegions.contains(element.region)) {
                  myRegions.add(element.region);
                }
              });
              myRegionsToDisplay =myRegions;

              return DistributorRegion(myRegionsToDisplay,myRegions, beats, refresh);
            }
            return Center(
              child: Image.asset(
                "assets/logo.png",
              ),
            );
          },
        ),
      ),

    );
  }
}
