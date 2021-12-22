import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.white,
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              Checkbox(
                value: allRegions.contains(widget.region),
                onChanged: (newstatus) {
                  if (newstatus ?? false) {
                    allRegions.add(widget.region);
                  } else {
                    allRegions.remove(widget.region);
                  }
                  widget.refresh();
                },
              ),
              Expanded(child: Text(widget.region)),
            ],
          ),
        ),
      ),
    );
  }
}
