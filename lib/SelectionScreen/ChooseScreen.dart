import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/EntityService/Beat.dart';
import 'package:nearestbeats/EntityService/BeatService.dart';
import 'package:nearestbeats/EntityService/OutletService.dart';
import 'package:nearestbeats/HomePage.dart';
import 'package:nearestbeats/data.dart';

import 'ExpandablePanel.dart';

class ChooseScreen extends StatefulWidget {
  final List<String> regions;
  final List<Beat> beats;

  const ChooseScreen(this.regions, this.beats);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "CHOOSE BEATS: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Builder(builder: (context) {
                List selectedRegions = [];
                for (var element in selectedBeats) {
                  if (!selectedRegions.contains(element.region)) {
                    selectedRegions.add(element.region);
                  }
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Wrap(
                    runAlignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    children: selectedRegions
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                for (var element in widget.beats
                                    .where((element) => element.region == e)
                                    .toList()) {
                                  bool isThere = false;
                                  for (var a in selectedBeats) {
                                    if (element.region == a.region &&
                                        element.distributor == a.distributor &&
                                        element.beat == a.beat) {
                                      isThere = true;
                                    }
                                  }
                                  if (isThere) {
                                    selectedBeats.remove(element);
                                  }
                                }
                                refresh();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      direction: Axis.horizontal,
                                      children: [
                                        Text(
                                          e,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.clear,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }),
              Column(
                children: widget.regions
                    .map(
                      (e) => ExpandablePanel1(
                          e, expand, currentExpanded, widget.beats, refresh),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (!isDisabled) {
              isDisabled = true;
              allOutlets = [];
              Map<String, String> body = {};
              selectedBeats.asMap().entries.forEach((element) {
<<<<<<< HEAD
                OutletService()
                    .fetchOutlet(context, element.value.beat,
                        element.value.distributor, element.value.region)
                    .then((value) {
                  int numberOfDone = 0;
                  for (var element in isDone) {
                    if (element) {
                      numberOfDone++;
                    }
                  }
                  setState(() {
                    animatorWidth = numberOfDone / selectedBeats.length;
                  });
                  allOutlets.addAll(value);
                  isDone[element.key] = true;
                  if (!isDone.contains(false)) {
                    animatorWidth = 0;
                    isDisabled = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const MyHomePage();
                        },
                      ),
                    );
                  }
=======
                body[element.key.toString()] = element.value.beatERPID;
              });
              OutletService().fetchOutlet(context, body).then((value) {
                allOutlets.addAll(value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return const MyHomePage();
                    },
                  ),
                );
                setState(() {
                  isDisabled = false;
>>>>>>> 49ed5a2fd664e801d5a1e2f0b4ee304aa3df3174
                });
              });
            }
          },
          child: Container(
            height: 50,
            color: Colors.red,
            child: isDisabled
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Center(
                    child: Text(
                      "NEXT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
