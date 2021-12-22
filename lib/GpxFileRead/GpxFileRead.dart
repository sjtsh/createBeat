import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Entity/Region.dart';
import 'package:nearestbeats/Backend/Service/RegionService.dart';
import 'package:nearestbeats/Data/Database.dart';
import 'package:nearestbeats/Data/data.dart';
import 'package:nearestbeats/HomePage.dart';
import 'package:nearestbeats/SelectionScreen/SelectionScreen.dart';

import '../data.dart';
import 'BeatsPolyline.dart';

class GpxFileRead extends StatefulWidget {
  @override
  _GpxFileReadState createState() => _GpxFileReadState();
}

class _GpxFileReadState extends State<GpxFileRead> {
  List<File> files = [];

  bool isFileLoaded = true;

  String dropdownValue = '';

  int regionID = 0;

  void _changedDropdown(input, e) {
    if (e.key == "Region") {
      regionID = allRegionLocal
          .firstWhere(
              (element) => element.regionID.toString() == input?.split("_")[1])
          .regionID;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Let's Start",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 3,
                        color: Colors.black.withOpacity(0.1)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FutureBuilder(
                      //     future: RegionService().fetchRegions(context),
                      //     builder: (context, AsyncSnapshot snapshot) {
                      //       if (snapshot.hasData) {
                      //         List<String> myRegions = [];
                      //         List<int> myRegionIDs = [];
                      //         List<Region> regions = snapshot.data;
                      //         regions.forEach((element) {
                      //           if (!myRegions.contains(element.regionName)) {
                      //             myRegions.add(element.regionName);
                      //           } else if (!myRegionIDs
                      //               .contains(element.regionID)) {
                      //             myRegionIDs.add(element.regionID);
                      //           }
                      //         });
                      //         return Column(
                      //           children: gpxFileDropdown.entries.map((e) {
                      //             List<String> myRegions = [];
                      //             if (e.key == "Region") {
                      //               (e.value[0] as List<Region>).forEach((e) =>
                      //                   myRegions.add(e.regionName +
                      //                       "_" +
                      //                       e.regionID.toString()));
                      //             }
                      //             return Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(e.key),
                      //                 SizedBox(
                      //                   height: 10,
                      //                 ),
                      //                 Container(
                      //                   height: 50,
                      //                   decoration: BoxDecoration(
                      //                     border:
                      //                         Border.all(color: Colors.grey),
                      //                   ),
                      //                   child: DropdownSearch<String>(
                      //                     showClearButton: false,
                      //                     mode: Mode.MENU,
                      //                     showSelectedItems: true,
                      //                     items: myRegions,
                      //                     hint: "Select " + e.key,
                      //                     dropdownSearchDecoration:
                      //                         InputDecoration(
                      //                             contentPadding:
                      //                                 EdgeInsets.only(left: 12),
                      //                             filled: true,
                      //                             fillColor: Color(0xffA0C7F4)
                      //                                 .withOpacity(0.1),
                      //                             border: InputBorder.none),
                      //                     showSearchBox: false,
                      //                     popupItemDisabled: (String s) =>
                      //                         s.startsWith('I'),
                      //                     onChanged: (input) {
                      //                       _changedDropdown(input, e);
                      //                     },
                      //                   ),
                      //                 ),
                      //               ],
                      //             );
                      //           }).toList(),
                      //         );
                      //       }
                      //       return Center(
                      //         child: Text("Blank"),
                      //       );
                      //     }),
                      Column(
                        children: gpxFileDropdown.entries.map((e) {
                          List<String> names = [];
                          if (e.key == "Region") {
                            (e.value[0] as List<Region>).forEach((e) =>
                                names.add(e.regionName +
                                    "_" +
                                    e.regionID.toString()));
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.key),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownSearch<String>(
                                  showClearButton: false,
                                  mode: Mode.MENU,
                                  showSelectedItems: true,
                                  items: names,
                                  hint: "Select " + e.key,
                                  dropdownSearchDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 12),
                                      filled: true,
                                      fillColor:
                                      Color(0xffA0C7F4).withOpacity(0.1),
                                      border: InputBorder.none),
                                  showSearchBox: false,
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (input) {
                                    _changedDropdown(input,e);
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Distributor"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownSearch<String>(
                          showClearButton: false,
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: ["AR Traders", "DS Trading"],
                          hint: "Select Distributor",
                          dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              fillColor: Color(0xffA0C7F4).withOpacity(0.1),
                              filled: true,
                              border: InputBorder.none),
                          showSearchBox: false,
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          // onChanged: (input) {
                          //   _changedDropdown(dropdownValue);
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 3,
                            spreadRadius: 3,
                            color: Colors.black.withOpacity(0.1))
                      ]),
                  child: Padding(
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
                        Expanded(
                          child: Padding(
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
                                        .then((result) => setState(() => files =
                                            result!.paths
                                                .map((path) => File(path!))
                                                .toList()));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Color(0xffA0C7F4).withOpacity(0.2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/file.png",
                                          height: 60,
                                          width: 80,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("Choose file here ...")
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: ListView.builder(
                                itemCount: files.length,
                                itemBuilder: (context, index) {
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  Icons.file_copy_sharp,
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Builder(
                                                      builder: (context) {
                                                    return Text(
                                                      files[index]
                                                          .path
                                                          .split("/")
                                                          .last,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 2,
                                                    );
                                                  }),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    files.removeAt(index);
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      const Divider(
                                        height: 2,
                                        thickness: 2,
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (isFileLoaded == true) {
                          await getFileData(files);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                // return const SelectionScreen();
                                return MyHomePage();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please choose gpx file")));
                        }
                      },
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          child: Center(child: const Text("Start")))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// reading data from file picked
  getFileData(List<File> datas) async {
    List<bool> bools = List.generate(datas.length, (index) => false);
    datas.asMap().entries.forEach((data) {
      data.value.readAsString().then(
            (file) => fileData(file).then((value) {
              polylinesLocal.add(
                Polyline(
                    polylineId: PolylineId(value.name),
                    points: value.LatLon,
                    visible: true,
                    color: colors[Random().nextInt(colors.length)],
                    width: 10),
              );
              bools[data.key - 1] = true;
              if (!bools.contains(false)) {
                return true;
              }
            }),
          );
    });
  }
}
