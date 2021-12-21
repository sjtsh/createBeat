import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                height: 10,
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
