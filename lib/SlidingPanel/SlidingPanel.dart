import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                          child: Image.network(
                            outlet.img,
                            fit: BoxFit.cover,
                          ),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              ((outlet.isAssigned) ?? false)
                                  ? outlet.newBeat.toString()
                                  : outlet.beatsName,
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
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: outletsForBeat.contains(outlet.id)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: Colors.red,
                                    child: InkWell(
                                      onTap: () {
                                        setMarkerRed(outlet.id);
                                      },
                                      child: Container(
                                        height: 60,
                                        child: Center(
                                          child: Text(
                                            "Remove from Beat",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: Colors.green,
                                    child: InkWell(
                                      onTap: () {
                                        setMarkerGreen(outlet.id);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            "Add to Beat",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _panelController.close();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
