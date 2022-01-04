import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Backend/Entity/OutletEntity.dart';
import '../data.dart';

class SlidingPanel extends StatefulWidget {
  final Outlet outlet;
  final bool isAdded;
  final Function setAdded;
  final Polyline polyline;
  final PanelController _panelController;
  final Function setMarkerRed;
  final Function setMarkerGreen;
  bool isPanelOpen;

  SlidingPanel(
      this.outlet,
      this.isAdded,
      this.setAdded,
      this.polyline,
      this._panelController,
      this.setMarkerRed,
      this.setMarkerGreen,
      this.isPanelOpen,
      {Key? key})
      : super(key: key);

  @override
  State<SlidingPanel> createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
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
                Expanded(child: Container()),
                Container(
                  height: 4,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.1)),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    widget._panelController.close();
                    setState(() {
                      widget.isPanelOpen = true;
                    });
                  },
                  child: widget.isPanelOpen == false
                      ? Container()
                      : Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: BeatsColors.headingColor,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.outlet.img,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.outlet.outletsName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: BeatsColors.headingColor,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/img.png",
                      width: 19,
                      height: 19,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(widget.outlet.beatsName),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/img_1.png",
                      width: 19,
                      height: 19,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(widget.outlet.distributor),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                outletsForBeat.contains(widget.outlet.id)
                    ? GestureDetector(
                        onTap: () {
                          widget.setMarkerRed(widget.outlet.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xff6C63FF),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "REMOVE FROM BEAT",
                              style: TextStyle(
                                color: BeatsColors.headingColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          widget.setMarkerGreen(widget.outlet.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xff6C63FF),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "ADD TO BEAT",
                              style: TextStyle(
                                color: Color(0xff6C63FF),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
