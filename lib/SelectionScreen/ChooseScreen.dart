import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Components/colors.dart';

import 'package:nearestbeats/NewUI/DistributorRegion.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
                  Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 3,
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(0.1))
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Step 1 of 3 ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: BeatsColors.textColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: BeatsColors.checkColor,
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  height: 5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: BeatsColors.greyColor,
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  height: 5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: BeatsColors.greyColor,
                                      borderRadius: BorderRadius.circular(7)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          "Choose Distributor Region ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: BeatsColors.textColor),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "1 Selected ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: BeatsColors.textColor),
                        ),
                      ],
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
                                    widget.refresh();
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
                              e, expand, currentExpanded, widget.beats, widget.refresh),
                        )
                        .toList(),
                  ),

                  Expanded(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, mainAxisSpacing: 16),
                        itemCount: 13,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  height: 72,
                                  width: 72,
                                  decoration: BoxDecoration(
                                      color: BeatsColors.circularAvatar,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: Text(index.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 36,
                                              color: Colors.white))),
                                ),
                              ),
                              Text(
                                "Gandaki",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: BeatsColors.textColor),
                              )
                            ],
                          );
                        }),
                  ),
                  SizedBox(height: 20,),

                ],
              ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return DistributorRegion();
            }));
          },
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: BeatsColors.checkColor,
                borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text("SELECT DISTRIBUTOR",

              style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white),)),
          ),
        )
      ],
    );



  }
}
