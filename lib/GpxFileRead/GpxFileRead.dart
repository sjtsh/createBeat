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
import 'package:nearestbeats/Backend/Service/RegionService.dart';
import 'package:nearestbeats/Data/Database.dart';
import 'package:nearestbeats/Data/data.dart';
import 'package:nearestbeats/Header.dart';

import 'package:nearestbeats/HomePage.dart';
import 'package:nearestbeats/SelectionScreen/ChooseScreen.dart';
import 'package:nearestbeats/SelectionScreen/ExpandablePanel.dart';
import 'package:nearestbeats/SelectionScreen/SelectionScreen.dart';

import '../data.dart';
import 'BeatsPolyline.dart';

class GpxFileRead extends StatefulWidget {
  @override
  _GpxFileReadState createState() => _GpxFileReadState();
}

class _GpxFileReadState extends State<GpxFileRead> {
  List<File> files = [];
  List<String> multiFileColor = [];
  String currentExpanded = "";
  bool isDisabled = false;

  expand(String currentExpanded) {
    setState(() {
      if (this.currentExpanded == currentExpanded) {
        this.currentExpanded = "";
      } else {
        this.currentExpanded = currentExpanded;
      }
    });
  }

  refresh() {
    setState(() {
      dropdownValue = "Select Distributor";
    });
  }

  setColor(int index, String color) {
    setState(() {
      multiFileColor[index] = color;
    });
  }

  String dropdownValue = 'Select Distributor';

  int regionID = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: BeatService().fetchBeats(context).then((value) {
              return value;
            }),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<String> myRegions = [];
                List<Beat> beats = snapshot.data;
                beats.forEach((element) {
                  if (!myRegions.contains(element.region)) {
                    myRegions.add(element.region);
                  }
                });
                print(myRegions);
                return ListView(
                  children: [
                    const Text(
                      "Let's Start",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ChooseScreen(myRegions, beats, refresh),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Distributor"),
                    SizedBox(
                      height: 10,
                    ),
                    Builder(
                      builder: (context) {
                      List<Beat> myList = beats
                          .where((element) =>
                          allRegions.contains(element.region)).toList();
                        return Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownSearch<String>(
                            showClearButton: false,
                            mode: Mode.MENU,
                            selectedItem: dropdownValue,
                            showSelectedItems: true,
                            items: List.generate(
                                myList.length,
                                    (index) => myList[index].distributor)
                                .toSet()
                                .toList(),
                            hint: "Select Distributor",
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8),
                                fillColor: Color(0xffA0C7F4).withOpacity(0.1),
                                filled: true,
                                border: InputBorder.none),
                            showSearchBox: true,
                            popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: (input) {
                              setState(() {
                                dropdownValue = input ?? "Select Distributor";
                              });
                            },
                          ),
                        );
                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Upload Files",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please select .gpx file.",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.4)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DottedBorder(
                                color: Color(0xffA0C7F4),
                                //color of dotted/dash line
                                strokeWidth: 1,
                                //thickness of dash/dots
                                dashPattern: [10, 6],
                                child: GestureDetector(
                                  onTap: () {
                                    FilePicker.platform
                                        .pickFiles(allowMultiple: true)
                                        .then((result) => setState(() {
                                              multiFileColor = List.generate(
                                                  result!.paths.length,
                                                  (index) => "Red");
                                              files = result.paths
                                                  .map((path) => File(path!))
                                                  .toList();
                                            }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Color(0xffA0C7F4).withOpacity(0.2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30.0),
                                          child: Image.asset(
                                            "assets/file.png",
                                            height: 60,
                                            width: 80,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: const Text(
                                              "Choose file here ..."),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        children: List.generate(
                          files.length,
                          (index) {
                            return Builder(
                              builder: (context) {
                                return Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: const Color(0xffA0C7F4)
                                          .withOpacity(0.1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.file_copy_sharp,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                files[index]
                                                    .path
                                                    .split("/")
                                                    .last,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection:
                                                    TextDirection.ltr,
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
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return MyDialogBox(
                                                        multiFileColor[index],
                                                        index,
                                                        setColor);
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.circle,
                                                color: multiFileColor[index] ==
                                                        "Red"
                                                    ? Colors.red
                                                    : multiFileColor[index] ==
                                                            "Blue"
                                                        ? Colors.blue
                                                        : Colors.green,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                files.removeAt(index);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.remove_circle_outline,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 2,
                                      thickness: 2,
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (files.isNotEmpty) {
                              if (dropdownValue != "Select Distributor") {
                                if (allRegions.isNotEmpty) {
                                  if (!isDisabled) {
                                    setState(() {
                                      isDisabled = true;
                                    });
                                    getFileData(files, multiFileColor, context);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Please select a beat")));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please select a distributor")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Please choose gpx file")));
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: isDisabled
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text("Start"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return Center(
                child: Image.asset(
                  "assets/logo.png",
                ),
              );
            },
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
                            return MyHomePage(files, polylines, dropdownValue);
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
