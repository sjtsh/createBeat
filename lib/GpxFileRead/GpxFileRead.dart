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
  String filePath = "Path of file";

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
              "Lets Start",
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
                                   onTap: (){
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
                      child: Container(
                          height: 60,
                          width: double.infinity,
                          color: Color(0xffA0C7F4).withOpacity(0.1),
                          child: ListTile(
                            leading: const Icon(
                              Icons.file_copy_sharp,
                            ),
                            title: Text(filePath.split("/").last),
                          )),
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
                      setState(() {
                        filePath;
                      });
                      getFileData(filePath);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return const SelectionScreen();
                          },
                        ),
                      );
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
      setState(() {
        filePath = (result.files.single.path!);
      });
    } else {
      // User canceled the picker

    }
  }

  /// reading data from file picked
  getFileData(data) async {
    final value = await File(data).readAsString();
    fileData(value).then((polylines) => polylinesLocal = [polylines].map(
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
