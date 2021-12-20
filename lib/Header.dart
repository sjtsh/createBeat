import 'package:flutter/material.dart';

import 'OutletEntity.dart';
import 'data.dart';

class Header extends StatelessWidget {
  final double radius;
  final double width;
  final List<Outlet> outlets;
  final Function changeRadius;

  Header(this.radius, this.width, this.outlets,
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

                Expanded(child: Container()),
                Text("${outlets.length} Outlets"),
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
