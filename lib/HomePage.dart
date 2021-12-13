import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nearestbeats/GoogleMapsPersonal/GoogleMapsPersonal.dart';
import 'package:nearestbeats/GoogleMapsPersonal/GoogleMapsSkeleton.dart';
import 'package:nearestbeats/Header.dart';
import 'package:nearestbeats/Methods/loadMarkersOutlets.dart';
import 'package:nearestbeats/SlidingPanel/SlidingPanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'OutletEntity.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double radius = 100;
  final TextEditingController _textController = TextEditingController();
  GoogleMapController? _googleMapController;
  String beatName = "";
  String searchBarInput = "";
  String distributorName = "";
  bool isTopShown = false;
  bool isAll = false;
  double distanceTravelled = 0;
  final PanelController _panelController = PanelController();

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    // Geolocator.getCurrentPosition().then((value) {
    //   controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         target: LatLng(value.latitude, value.longitude),
    //         zoom: 17,
    //         tilt: 50,
    //       ),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadMarkerOutlets(searchBarInput, beatName, changeBeatName,
              distributorName, isAll, radius),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Marker> markers = snapshot.data[0];
              List<Outlet> outlets = snapshot.data[1];
              Position myPosition = snapshot.data[2];
              // double myLat = 27.725896;
              // double myLng = 85.343256;
              outlets.sort(
                (a, b) => GeolocatorPlatform.instance
                    .distanceBetween(
                        myPosition.latitude, myPosition.longitude, a.lat, a.lng)
                    // myLat,
                    // myLng,
                    // a.lat,
                    // a.lng)
                    .compareTo(
                      GeolocatorPlatform.instance.distanceBetween(
                          myPosition.latitude,
                          myPosition.longitude,
                          // myLat,
                          // myLng,
                          b.lat,
                          b.lng),
                    ),
              );
              return SlidingUpPanel(
                controller: _panelController,
                isDraggable: true,
                color: Colors.transparent,
                panel: SlidingPanel(beatName, outlets, myPosition,
                    _textController, searchSubmitted, changeBeatName),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(radius, width, beatName, distributorName, outlets,
                        changeRadius),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                        child: GoogleMapsPersonal(beatName, markers, isAll,
                            _onMapCreated, removeBeat, changeAll, refresh)),
                  ],
                ),
              );
            }
            return const GoogleMapsSkeleton();
          },
        ),
      ),
    );
  }

  void changeBeatName(Outlet outlet) {
    setState(
      () {
        beatName = outlet.beatsName;
        distributorName = outlet.distributor;
        searchBarInput = "";
      },
    );
    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(outlet.lat, outlet.lng),
          zoom: 17,
          tilt: 50,
        ),
      ),
    );
    _panelController.animatePanelToPosition(0.5,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    _googleMapController?.showMarkerInfoWindow(MarkerId(outlet.id.toString()));
  }

  void removeBeat() {
    setState(
      () {
        beatName = "";
        distributorName = "";
        searchBarInput = "";
      },
    );
  }

  changeAll(bool newIsAll) {
    setState(
      () {
        isAll = newIsAll;
      },
    );
    if (newIsAll) {
      Geolocator.getCurrentPosition().then((value) {
        _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(27.650136, 85.337996, ),
            // target: LatLng(value.latitude, value.longitude),
            zoom: 10,
            tilt: 50,
          ),
        ));
      });
    }
  }

  void refresh() {
    setState(() {
      radius += 1;
      radius -= 1;
    });
  }

  void changeRadius(newRadius) {
    setState(() {
      radius = newRadius;
    });
  }

  void searchSubmitted() {
    setState(() {
      searchBarInput = _textController.text;
      _textController.clear();
    });

    _panelController.animatePanelToPosition(0.5,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}
