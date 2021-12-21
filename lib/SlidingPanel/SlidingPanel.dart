import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearestbeats/outletInfo/outletInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../OutletEntity.dart';

class SlidingPanel extends StatelessWidget {
  final Outlet outlet;
  final Position myPosition;
  final bool isAdded;
  final Function setAdded;

  SlidingPanel(
    this.outlet,
    this.myPosition,
    this.isAdded,
    this.setAdded,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffFAF9F9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 4,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.black.withOpacity(0.1)),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 150,
                        color: Colors.green,
                        child: Image.network(outlet.img),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            outlet.outletsName,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            outlet.beatsName,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Text(
                            outlet.distributor,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: isAdded ? Colors.red : Colors.green,
                    child: InkWell(
                      onTap: () {
                        setAdded(!isAdded);
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            isAdded ? "Remove from Beat" : "Add to Beat",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
