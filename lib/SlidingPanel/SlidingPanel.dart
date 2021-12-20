import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearestbeats/outletInfo/outletInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../OutletEntity.dart';

class SlidingPanel extends StatelessWidget {
  final String beatName;
  final List<Outlet> outlets;
  final Position myPosition;
  final TextEditingController _textController;
  final Function searchSubmitted;
  final Function changeBeatName;

  SlidingPanel(this.beatName, this.outlets, this.myPosition,
      this._textController, this.searchSubmitted, this.changeBeatName);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: const BoxDecoration(
        color: Color(0xffFAF9F9),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
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
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                beatName.isEmpty
                    ? "All outlets near you"
                    : "All outlets in the beat",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  ...outlets
                      .asMap()
                      .entries
                      .map(
                        (e) => Column(
                          children: [
                            Slidable(
                              closeOnScroll: true,
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.2,
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: (_) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OutletInfo(e.value),
                                        ),
                                      );
                                    },
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.black,
                                    icon: Icons.remove_red_eye,
                                    label: 'View',
                                  ),
                                ],
                              ),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      changeBeatName(e.value);
                                    },
                                    child: Container(
                                      height: 100,
                                      child: Row(children: [
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        // CircleAvatar(
                                        //   backgroundColor: Colors.grey,
                                        //   child: Center(
                                        //       child: Text(
                                        //     e.value.outletsName
                                        //         .substring(0, 1)
                                        //         .toUpperCase(),
                                        //     style: const TextStyle(
                                        //         fontSize: 16,
                                        //         color: Colors.black,
                                        //         fontWeight: FontWeight.bold),
                                        //   ),),
                                        // ),
                                        Container(
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                e.value.img,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.value.outletsName,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                e.value.beatsName,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Builder(
                                          builder: (context) {
                                            double distance = GeolocatorPlatform
                                                .instance
                                                .distanceBetween(
                                                    myPosition.latitude,
                                                    myPosition.longitude,
                                                    e.value.lat,
                                                    e.value.lng);
                                            String toPrint = distance < 1000
                                                ? "${distance.toStringAsFixed(0)}m"
                                                : "${(distance / 1000).toStringAsFixed(1)}km";
                                            return Container(
                                              height: 40,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Material(
                                                color: Colors.white,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      launch(
                                                          'https://www.google.com/maps/search/?api=1&query=${e.value.lat},${e.value.lng}');
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 3,
                                                          bottom: 3,
                                                          right: 8,
                                                          left: 8),
                                                      child: Center(
                                                        child: Text(toPrint),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        // "${GeolocatorPlatform.instance.distanceBetween(myLat, myLng, e.value.lat, e.value.lng).toStringAsFixed(0)}m"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      )
                      .toList()
                ],
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (String input) {
                  searchSubmitted();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
