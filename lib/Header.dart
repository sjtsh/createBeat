import 'package:flutter/material.dart';

import 'OutletEntity.dart';
import 'data.dart';

class Header extends StatelessWidget {
  final double radius;
  final double width;
  final String beatsName;
  final String distributor;
  final List<Outlet> outlets;
  final Function changeRadius;

  Header(this.radius, this.width, this.beatsName, this.distributor, this.outlets,
      this.changeRadius);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
            offset: Offset(0, -2),
            blurRadius: 3,
          ),
        ],
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                beatsName == ""
                    ? Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            beatsName.length >= 35
                                ? beatsName.substring(0, 35)
                                : beatsName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (distributor != "")
                            Text(
                              distributor.length >= 35
                                  ? distributor.substring(0, 35)
                                  : distributor,
                              style: TextStyle(fontSize: 10),
                            )
                          else
                            Container()
                        ],
                      ),
                Expanded(child: Container()),
                Text(beatsName.isEmpty
                    ? "${outlets.length} Outlets in ${radius.toStringAsFixed(0)}m Radius"
                    : "${outlets.length} Outlets"),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
          Slider(
            onChangeEnd: (double value) {
              changeRadius(value * 1000);
            },
            value: radius > 1000 ? 1 : (radius / 1000),
            onChanged: (double value) {},
            divisions: 10,
            activeColor: Colors.black.withOpacity(0.5),
            thumbColor: Colors.black,
            inactiveColor: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
