import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Backend/Entity/OutletEntity.dart';
import '../data.dart';

class SlidingPanel extends StatelessWidget {
  final Outlet outlet;
  final bool isAdded;
  final Function setAdded;
  final Polyline polyline;
  final PanelController _panelController;
  final isPanelClosed = false;
  final Function setMarkerRed;
  final Function setMarkerGreen;

  SlidingPanel(this.outlet, this.isAdded, this.setAdded, this.polyline,
      this._panelController, this.setMarkerRed, this.setMarkerGreen,
      {Key? key})
      : super(key: key);

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
            Row(
              children: [
                Container(
                  height: 4,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.1)),
                ),

              ],
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          outlet.img,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    outlet.beatsName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: BeatsColors.headingColor,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/img.png",
                        width: 19,
                        height: 19,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(outlet.outletsName),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/img_1.png",
                        width: 19,
                        height: 19,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(outlet.distributor),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                          color: Color(0xff6C63FF),
                        ),),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "ADD TO BEAT",
                            style: TextStyle(
                              color: Color(0xff6C63FF),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: (){
                          _panelController.close();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: BeatsColors.headingColor,
                            ),),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "CLOSE",
                              style: TextStyle(
                                color: BeatsColors.headingColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: outletsForBeat.contains(outlet.id)
                  //           ? Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Container(
                  //                 clipBehavior: Clip.hardEdge,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(12),
                  //                 ),
                  //                 child: Material(
                  //                   color: Colors.red,
                  //                   child: InkWell(
                  //                     onTap: () {
                  //                       setMarkerRed(outlet.id);
                  //                     },
                  //                     child: Container(
                  //                       height: 60,
                  //                       child: Center(
                  //                         child: Text(
                  //                           "Remove from Beat",
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 14),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             )
                  //           : Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Container(
                  //                 clipBehavior: Clip.hardEdge,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(12),
                  //                 ),
                  //                 child: Material(
                  //                   color: Colors.green,
                  //                   child: InkWell(
                  //                     onTap: () {
                  //                       setMarkerGreen(outlet.id);
                  //                     },
                  //                     child: Container(
                  //                       height: 60,
                  //                       width: double.infinity,
                  //                       child: Center(
                  //                         child: Text(
                  //                           "Add to Beat",
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 14),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //     ),
                  //     Expanded(
                  //       child: InkWell(
                  //         onTap: () {
                  //           _panelController.close();
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Container(
                  //             height: 60,
                  //             decoration: BoxDecoration(
                  //               color: Colors.blueGrey,
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 "Close",
                  //                 style: TextStyle(
                  //                     fontSize: 20, color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
