import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/EntityService/Beat.dart';

import '../data.dart';
import 'ExpandablePanel2.dart';

class ExpandablePanel1 extends StatefulWidget {
  final String region;
  final Function expand;
  final String currentExpanded;
  final List<Beat> beats;
  final Function refresh;

  ExpandablePanel1(
      this.region, this.expand, this.currentExpanded, this.beats, this.refresh);

  @override
  _ExpandablePanelState createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel1> {
  String currentlyExpanded = "";

  expanded(String currentlyExpanded) {
    setState(() {
      if (this.currentlyExpanded == currentlyExpanded) {
        this.currentlyExpanded = "";
      } else {
        this.currentlyExpanded = currentlyExpanded;
      }
    });
  }

  final ExpandableController _expandableControllerMain = ExpandableController();

  @override
  Widget build(BuildContext context) {
    if (widget.currentExpanded == widget.region) {
      _expandableControllerMain.expanded = true;
    } else {
      _expandableControllerMain.expanded = false;
    }
    return ExpandablePanel(
      controller: _expandableControllerMain,
      collapsed: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.expand(widget.region);
                _expandableControllerMain.expanded =
                    !_expandableControllerMain.expanded;
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Text(widget.region)),
                    Icon(Icons.keyboard_arrow_down_sharp)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      expanded: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.expand(widget.region);
                _expandableControllerMain.expanded =
                    !_expandableControllerMain.expanded;
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      List distributors = [];
                      List<Beat> myBeats = widget.beats
                          .where((element) => element.region == widget.region)
                          .toList();
                      myBeats.forEach((element) {
                        if (!distributors.contains(element.distributor)) {
                          distributors.add(element.distributor);
                        }
                      });
                      bool distributorValue = true;
                      for (var element in myBeats) {
                        bool isThere = false;
                        for (var a in selectedBeats) {
                          if (element.region == a.region &&
                              element.distributor == a.distributor &&
                              element.beat == a.beat) {
                            isThere = true;
                          }
                        }
                        if (!isThere) {
                          distributorValue = false;
                        }
                      }
                      return Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: distributorValue,
                                onChanged: (newstatus) {
                                  if (newstatus ?? false) {
                                    for (var element in myBeats) {
                                      bool isThere = false;
                                      for (var a in selectedBeats) {
                                        if (element.region == a.region &&
                                            element.distributor ==
                                                a.distributor &&
                                            element.beat == a.beat) {
                                          isThere = true;
                                        }
                                      }
                                      if (!isThere) {
                                        selectedBeats.add(element);
                                      }
                                    }
                                  } else {
                                    for (var element in myBeats) {
                                      bool isThere = false;
                                      for (var a in selectedBeats) {
                                        if (element.region == a.region &&
                                            element.distributor ==
                                                a.distributor &&
                                            element.beat == a.beat) {
                                          isThere = true;
                                        }
                                      }
                                      if (isThere) {
                                        selectedBeats.remove(element);
                                      }
                                    }
                                  }
                                  widget.refresh();
                                },
                              ),
                              Expanded(child: Text(widget.region)),
                              Icon(Icons.keyboard_arrow_up)
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Column(
                            children: distributors.map((f) {
                              bool isAlreadySelected = false;
                              for (var element in selectedBeats) {
                                if (element.distributor == f &&
                                    element.region == widget.region) {
                                  isAlreadySelected = true;
                                  break;
                                }
                              }
                              return ExpandablePanel2(
                                  f,
                                  widget.region,
                                  expanded,
                                  currentlyExpanded,
                                  myBeats,
                                  widget.refresh,
                                  isAlreadySelected);
                            }).toList(),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
