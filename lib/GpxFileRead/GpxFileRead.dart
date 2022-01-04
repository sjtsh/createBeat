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
import 'package:nearestbeats/Components/colors.dart';

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
  bool isTapped = false;
  int fileLength = 0;

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
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
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
                          "Upload Map Files",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                    thickness: 1.5,
                    height: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 12.0, top: 22.0),
                    child: const Text(
                      "Upload Route Files",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff676767),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        FilePicker.platform
                            .pickFiles(
                              allowMultiple: true,
                            )
                            .then((result) => setState(() {
                                  multiFileColor = List.generate(
                                      result!.paths.length + 10,
                                      (index) => "Red");
                                  result.paths
                                      .map((path) => File(path!))
                                      .toList()
                                      .forEach((element) {
                                    bool isThere = false;
                                    for (var file in files) {
                                      if (file.path == element.path) {
                                        isThere = true;
                                        break;
                                      }
                                    }
                                    if (!isThere) {
                                      files.add(element);
                                    }
                                  });

                                  fileLength = files.length;
                                }));
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(6),
                        color: Color(0xff6C63FF),
                        strokeWidth: 1,
                        dashPattern: [10, 6],
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: Center(
                            child: const Text(
                              "ADD NEW FILE",
                              style: TextStyle(
                                color: Color(0xff6C63FF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 12.0, top: 12.0),
                    child:  Text(
                      "${fileLength} Files Uploaded",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff676767),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 12,
                    ),
                    child: Column(
                      children: List.generate(
                        files.length,
                        (index) {
                          return Builder(
                            builder: (context) {
                              return Column(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                            color:
                                                Colors.black.withOpacity(0.1)),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return MyDialogBox(
                                                        multiFileColor[index],
                                                        index,
                                                        setColor);
                                                  });
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: multiFileColor[index] ==
                                                    "Red"
                                                    ? Colors.red
                                                    : multiFileColor[index] ==
                                                    "Blue"
                                                    ? Colors.blue
                                                    : Colors.green,
                                              ),
                                            ),
                                          ),
                                         SizedBox(width: 20,),
                                          Expanded(
                                            child: Text(
                                              files[index].path.split("/").last,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.justify,
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),

                                          IconButton(
                                            onPressed: () {
                                              files.removeAt(index);
                                              setState(() {
                                                fileLength= files.length;
                                              });
                                            },
                                            icon: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red),
                                              child: Center(
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 13,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff6C63FF),
                          borderRadius: BorderRadius.circular(6)),
                      child: MaterialButton(
                        onPressed: () {
                          if(fileLength!=0) {
                            setState(() {
                              isTapped =true;
                            });
                            getFileData(files, multiFileColor, context);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please add file to continue"),duration: Duration(seconds: 1),));
                          }
                        },
                        child: Center(
                          child:isTapped? const CircularProgressIndicator(color: Colors.white,): const Text(
                            "UPLOAD ROUTES",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
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
    );
  }

  /// reading data from file picked
  getFileData(List<File> datas, List<String> multiFileColor, context) async {
    print(datas);
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
                    width: 2),
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
                        isTapped =false;
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
    return Center(
      child: Material(
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xffF5F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            height: 220,
            width: 250,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Align(alignment:Alignment.centerLeft,child: Text("Select Path Color", style: TextStyle(fontWeight: FontWeight.bold, color: BeatsColors.headingColor),)),
                ),
                Column(
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
                                        border: Border.all(color:  e.value == "Red"
                                            ? Colors.red
                                            : e.value =="Blue" ? Colors.blue : Colors.green),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                          color: e.value == "Red"
                                              ? Colors.red
                                              : e.value =="Blue" ? Colors.blue : Colors.green,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
