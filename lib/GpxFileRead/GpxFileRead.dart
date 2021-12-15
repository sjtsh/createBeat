import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/SelectionScreen/SelectionScreen.dart';

import '../data.dart';
import 'BeatsPolyline.dart';

class GpxFileRead extends StatefulWidget {
  @override
  _GpxFileReadState createState() => _GpxFileReadState();
}

class _GpxFileReadState extends State<GpxFileRead> {
  String filePath = "";
  String fileName = "";
  bool isFileLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please select .gpx file.",
                      style: TextStyle(color: Colors.black.withOpacity(0.4)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DottedBorder(
                          color: Color(0xffA0C7F4), //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          dashPattern: [10, 6],
                          child: GestureDetector(
                            onTap: () {
                              pickFile();
                            },
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              color: Color(0xffA0C7F4).withOpacity(0.2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: isFileLoaded == true
                          ? Container(
                              height: 60,
                              width: double.infinity,
                              color: const Color(0xffA0C7F4).withOpacity(0.1),
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
                                      child: Text(
                                        fileName,
                                        overflow: TextOverflow.ellipsis,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.justify,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isFileLoaded = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (isFileLoaded == true) {
                        getFileData(filePath);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return const SelectionScreen();
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please choose gpx file")));
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
    );
  }

  /// pick files from device
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      // if (filePath.split(".").last == "gpx") {
      filePath = (result.files.single.path!);
      fileName = filePath.split("/").last;

      ///checking file type

      if (fileName.split(".").last == "gpx") {
        setState(() {
          fileName;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("File type is not gpx")));
      }
    } else {
      // User canceled the picker

    }
    isFileLoaded = true;
  }

  /// reading data from file picked
  getFileData(data) async {
    final value = await File(data).readAsString();
    fileData(value).then((polylines) => polylinesLocal = [polylines]
        .map(
          (e) => Polyline(
              polylineId: PolylineId(e.name),
              points: e.LatLon,
              visible: true,
              color: colors[Random().nextInt(colors.length)],
              width: 10),
        )
        .toSet());
  }
}
