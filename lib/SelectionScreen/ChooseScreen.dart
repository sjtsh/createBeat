import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Service/OutletService.dart';
import 'package:nearestbeats/HomePage.dart';
import 'package:nearestbeats/data.dart';

import 'ExpandablePanel.dart';

class ChooseScreen extends StatefulWidget {
  final List<String> regions;
  final List<Beat> beats;
  final Function refresh;

  const ChooseScreen(this.regions, this.beats, this.refresh);

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
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "CHOOSE BEATS: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Wrap(
                  runAlignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: allRegions
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              allRegions.remove(e);
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
      ],
    );
  }
}
