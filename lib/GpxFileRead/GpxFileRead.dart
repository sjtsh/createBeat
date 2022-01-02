import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Entity/Region.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';
import 'package:nearestbeats/Backend/Service/OutletService.dart';

import 'package:nearestbeats/Header.dart';

import 'package:nearestbeats/HomePage.dart';
import 'package:nearestbeats/NewUI/DistributorRegion.dart';
import 'package:nearestbeats/SelectionScreen/ChooseScreen.dart';
import 'package:nearestbeats/SelectionScreen/ExpandablePanel.dart';

import '../data.dart';
import 'BeatsPolyline.dart';

class GpxFileRead extends StatefulWidget {
  final String dropdownValue;
  GpxFileRead(this.dropdownValue);

  @override
  _GpxFileReadState createState() => _GpxFileReadState();
}

class _GpxFileReadState extends State<GpxFileRead> {
  List<File> files = [];
  List<String> multiFileColor = [];
  String currentExpanded = "";
  bool isDisabled = false;

  // expand(String currentExpanded) {
  //   setState(() {
  //     if (this.currentExpanded == currentExpanded) {
  //       this.currentExpanded = "";
  //     } else {
  //       this.currentExpanded = currentExpanded;
  //     }
  //   });
  // }


  setColor(int index, String color) {
    setState(() {
      multiFileColor[index] = color;
    });
  }

 // String dropdownValue = 'Select Distributor';

  int regionID = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          Expanded(child: Container()),
                          const Text(
                            "Select Distributor",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Upload Route Files",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff676767),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(child: Container()),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff6C63FF),
                          borderRadius: BorderRadius.circular(6)),
                      child: MaterialButton(
                        onPressed: () {
                          print(checkedDetails);
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return DistributorRegion();
                          // }));
                        },
                        child: Center(
                          child: Text(
                            "SELECT DISTRIBUTOR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// reading data from file picked
  getFileData(List<File> datas, List<String> multiFileColor, context) async {
    List<bool> bools = List.generate(datas.length, (index) => false);
    Set<Polyline> polylines = {};
    allOutlets = [];
    outletsForBeat = [];
    datas.asMap().entries.forEach((data) {
      data.value.readAsString().then(
            (file) => fileData(file).then((value) {
              polylines.add(
                Polyline(
                    polylineId: PolylineId(value.name),
                    points: value.LatLon,
                    visible: true,
                    color: multiFileColor[data.key] == "Red"
                        ? Colors.red
                        : multiFileColor[data.key] == "Blue"
                            ? Colors.blue
                            : Colors.green,
                    width: 5),
              );
              bools[data.key] = true;
              if (!bools.contains(false)) {
                List<bool> bool1s =
                    List.generate(allRegions.length, (index) => false);
                for (int i = 0; i < allRegions.length; i++) {
                  print(allRegions[i]);
                  OutletService()
                      .fetchOutlet(context, allRegions[i])
                      .then((value) {
                    allOutlets.addAll(value);
                    bool1s[i] = true;
                    if (!bool1s.contains(false)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return MyHomePage(
                              files,
                              polylines,
                              widget.dropdownValue,
                              multiFileColor,
                            );
                          },
                        ),
                      );
                      setState(() {
                        isDisabled = false;
                      });
                    }
                  });
                }
              }
            }),
          );
    });
  }
}

class MyDialogBox extends StatefulWidget {
  final String colorSelected;
  final int index;
  final Function setColor;

  MyDialogBox(this.colorSelected, this.index, this.setColor);

  @override
  State<MyDialogBox> createState() => _MyDialogBoxState();
}

class _MyDialogBoxState extends State<MyDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.8, 0.5 + widget.index * 0.1),
      child: Material(
          child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: <String>["Red", "Blue", "Green"]
              .asMap()
              .entries
              .map((e) => InkWell(
                    onTap: () {
                      widget.setColor(widget.index, e.value);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.value),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  color: e == widget.colorSelected
                                      ? Colors.blue
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      )),
    );
  }
}
