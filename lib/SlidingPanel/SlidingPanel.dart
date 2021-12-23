import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearestbeats/outletInfo/outletInfo.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Backend/Entity/OutletEntity.dart';

class SlidingPanel extends StatelessWidget {
  final Outlet outlet;
  final bool isAdded;
  final Function setAdded;
  PanelController _panelController;
  final isPanelClosed = false;

  SlidingPanel(this.outlet, this.isAdded, this.setAdded, this._panelController);

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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.green,
                          child: Image.network(outlet.img, fit: BoxFit.cover,),
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                    height: 10,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.green,
                      child: InkWell(
                        onTap: () {
                          setAdded(!isAdded);
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Add to Beat",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.red,
                      child: InkWell(
                        onTap: () {
                          setAdded(!isAdded);
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Remove from Beat",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      _panelController.close();
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      _panelController.close();
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
