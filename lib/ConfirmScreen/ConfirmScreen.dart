import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/OutletEntity.dart';
import 'package:nearestbeats/Backend/Service/OutletService.dart';
import 'package:nearestbeats/GpxFileRead/GpxFileRead.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data.dart';

class ConfirmScreen extends StatefulWidget {
  final String distributorName;
  final String beatName;
  final Function setMarkerRed;
  final Function changeRadius;

  ConfirmScreen(
    this.distributorName,
    this.beatName,
    this.setMarkerRed,
    this.changeRadius,
  );

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController beat = TextEditingController();

  TextEditingController distributor = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isDisabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    beat.text = widget.beatName;
    distributor.text = widget.distributorName;
  }

  @override
  Widget build(BuildContext context) {
    List<Outlet?> toListOutlets =
        List.generate(outletsForBeat.toSet().length, (index) {
      for (var element in allOutlets) {
        if (element.id == outletsForBeat[index]) {
          return element;
        }
      }
    }).toSet().toList();
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3)
              ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Confirm",
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                        "No of Outlets: ${outletsForBeat.length.toString()}"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: distributor,
                      enableSuggestions: true,
                      validator: (dis) {
                        if (dis == null || dis.isEmpty) {
                          return 'Please enter Distributor';
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        hintText: "Distributor",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: beat,
                      enableSuggestions: true,
                      validator: (beat) {
                        if (beat == null || beat.isEmpty) {
                          return 'Please enter beat';
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        hintText: "Beat Name",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                        children: toListOutlets.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 3,
                                  color: Colors.black.withOpacity(0.1),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (e?.outletsName.toString()) ??
                                                "unknown",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            (e?.ownersNumber.toString()) ??
                                                "unknown",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                          Text(
                                            ((e?.isAssigned) ?? false)
                                                ? (e?.newBeat ?? "unknown")
                                                    .toString()
                                                : (e?.beatsName) ?? "unknown",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Container(
                                            width: 100,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Material(
                                              color: Colors.white,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.blue),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (e != null) {
                                                      launch(
                                                          'https://www.google.com/maps/search/?api=1&query=${e.lat},${e.lng}');
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 3,
                                                        bottom: 3,
                                                        right: 8,
                                                        left: 8),
                                                    child: Builder(
                                                        builder: (context) {
                                                      return Center(
                                                        child: Text(
                                                          "View on Maps",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.network(
                                      (e?.img) ?? "",
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Center(
                                          child: Text('Couldnt Load'),
                                        );
                                      },
                                      fit: BoxFit.contain,
                                      width: 100,
                                      height: 100,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          outletsForBeat.remove(e?.id);
                                          widget.setMarkerRed((e?.id) ?? 0);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      );
                    }).toList()),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, bottom: 12),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.green,
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate() && !isDisabled) {
                        setState(
                          () {
                            isDisabled = true;
                          },
                        );

                        Map<String, Map<String, String>> aBody = {};
                        for (int element in outletsForBeat) {
                          aBody[element.toString()] = {
                            "beat": beat.text,
                            "distributor": distributor.text,
                          };
                        }
                        OutletService().updateOutlet(context, aBody).then(
                          (value) {
                            allOutlets = [];
                            outletsForBeat = [];
                            List<bool> bool1s = List.generate(
                                allRegions.length, (index) => false);
                            for (int i = 0; i < allRegions.length; i++) {

                              OutletService()
                                  .fetchOutlet(context, allRegions[i])
                                  .then((value) {
                                allOutlets.addAll(value);
                                bool1s[i] = true;
                                if (!bool1s.contains(false)) {
                                  widget.changeRadius(1000.0);
                                  setState(() {
                                    isDisabled = false;
                                  });
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
                        );
                      }
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      child: Center(
                        child: isDisabled
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
