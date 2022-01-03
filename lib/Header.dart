import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearestbeats/Components/colors.dart';

import 'Backend/Entity/OutletEntity.dart';
import 'ConfirmationScreen/confirmationScreen.dart';
import 'data.dart';

class Header extends StatefulWidget {
  final double radius;
  final Function changeRadius;
  final List<File> dropdownFiles;
  final Set polylines;
  final Polyline polyline;
  final GoogleMapController? googleMapController;
  final double greenRadius;
  final Function changeGreenRadius;
  final Function changePolyline;
  final distributorName;
  final String beatName;

  final Function setMarkerRed;
  final contexts;

  final List<String> multiFileColor;


  Header(
    this.radius,
    this.changeRadius,
    this.dropdownFiles,
    this.polylines,
    this.polyline,
    this.greenRadius,
    this.changeGreenRadius,
    this.changePolyline,
    this.distributorName,
    this.beatName,
    this.setMarkerRed,
    this.contexts,
    this.multiFileColor,
      {
    this.googleMapController,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String dropdownValue = "Select Distributor";
  bool isExpanded = false;
  bool isExpanded2 = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(widget.contexts).size.width;
    double mapRadius =widget.radius.ceilToDouble();
    double areaRadius =widget.greenRadius.ceilToDouble();


    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     Expanded(
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const SizedBox(
    //             width: 12,
    //           ),
    //           Text(widget.distributorName),
    //           Expanded(
    //             child: Container(),
    //           ),
    //           Text("${outletsForBeat.length} Outlets"),
    //           const SizedBox(
    //             width: 12,
    //           ),
    //         ],
    //       ),
    //     ),
    //     Slider(
    //       onChangeEnd: (double value) {
    //         widget.changeRadius(value * 2000);
    //       },
    //       value: widget.radius > 2000 ? 1 : (widget.radius / 2000),
    //       onChanged: (double value) {},
    //       divisions: 20,
    //       label: widget.radius.toString(),
    //       activeColor: Colors.red.withOpacity(0.5),
    //       thumbColor: Colors.red,
    //       inactiveColor: Colors.black.withOpacity(0.1),
    //     ),
    //     Slider(
    //       onChangeEnd: (double value) {
    //         widget.changeGreenRadius(value * 200);
    //       },
    //       value: widget.greenRadius > 200 ? 1 : (widget.greenRadius / 200),
    //       onChanged: (double value) {},
    //       divisions: 20,
    //       label: widget.greenRadius.toString(),
    //       activeColor: Colors.green.withOpacity(0.5),
    //       thumbColor: Colors.green,
    //       inactiveColor: Colors.black.withOpacity(0.1),
    //     ),
    //     DropdownSearch<String>(
    //       showClearButton: false,
    //       mode: Mode.MENU,
    //       selectedItem: widget.polyline.polylineId.value,
    //       showSelectedItems: true,
    //       items: List.generate(
    //           widget.polylines.length,
    //           (index) =>
    //               widget.polylines.toList()[index].polylineId.value +
    //               "(${widget.multiFileColor[index].substring(0, 1).toUpperCase()})"),
    //       hint: "Select Distributor",
    //       dropdownSearchDecoration: InputDecoration(
    //           contentPadding: EdgeInsets.only(left: 8),
    //           fillColor: Color(0xffA0C7F4).withOpacity(0.1),
    //           filled: true,
    //           border: InputBorder.none),
    //       showSearchBox: true,
    //       popupItemDisabled: (String s) => s.startsWith('I'),
    //       onChanged: (input) {
    //         widget.changePolyline(input?.substring(0, input.length - 3));
    //
    //       },
    //     ),
    //   ],
    // );
    return Column(
      children: [
        Container(

          height: 50,
          width: width - 24,
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: !isExpanded? BorderRadius.circular(16):BorderRadius.only(topLeft:Radius.circular(16),topRight:Radius.circular(16),),
            boxShadow:  [BoxShadow(
              offset: Offset(0,2),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.1)
            )]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {

                        setState(() {
                          isExpanded = !isExpanded;
                          if(!isExpanded2){
                            // when decreasing
                            Future.delayed(
                                Duration(milliseconds: 200))
                                .then((value) {
                              setState(() {

                                isExpanded2 = !isExpanded2;
                              });
                            });
                          }else{
                            //when increasing
                            isExpanded2 = !isExpanded2;
                          }
                        });
                      },
                      icon: isExpanded
                          ? Icon(Icons.close)
                          : Icon(Icons.line_weight_sharp)),
                  Expanded(child: Container()),
                  Text("1 outlet selected"),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {

                              return ConfirmationScreen(widget.distributorName, widget.beatName, widget.setMarkerRed);

                            },
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          ),
        ),
        Builder(builder: (context) {

          return AnimatedContainer(
            width: width - 24,
            height: isExpanded ? 250 : 0,

            duration: Duration(milliseconds: 200),
              decoration:  BoxDecoration(

                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight:Radius.circular(16),bottomLeft:Radius.circular(16),),
                  boxShadow: [BoxShadow(
                      offset: Offset(0,2),
                      blurRadius: 3,
                    color: Colors.black.withOpacity(0.1),
                  )]
              ),
            child: isExpanded2
                ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
              children: [
                  DropdownSearch<String>(

                    showClearButton: false,
                    mode: Mode.MENU,
                    selectedItem: widget.polyline.polylineId.value,
                    showSelectedItems: true,
                    items: List.generate(
                        widget.polylines.length,
                            (index) =>
                        widget.polylines.toList()[index].polylineId.value +
                            "(${widget.multiFileColor[index].substring(0, 1).toUpperCase()})"),
                    hint: "Select Distributor",
                    dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),

                        border: InputBorder.none),
                    showSearchBox: true,
                    popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (input) {
                      widget.changePolyline(input?.substring(0, input.length - 3));

                    },
                  ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                  children: [
                    Text("Map Radius", style:TextStyle(fontWeight: FontWeight.bold, color:BeatsColors.headingColor )),
                    Expanded(child: Container()),
                    Text("${mapRadius.toString()}m", style:TextStyle(fontWeight: FontWeight.bold, color:BeatsColors.headingColor )),
                  ],
              ),
            ),
            Slider(

                    onChangeEnd: (double value) {
                      widget.changeRadius(value * 2000);
                    },
                    value: widget.radius > 2000 ? 1 : (widget.radius / 2000),
                    onChanged: (double value) {
                      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                        setState(() {
                          mapRadius = value;
                        });
                      });
                    },
                    label: widget.radius.toString(),
                    activeColor: BeatsColors.inputBgColor,
                    thumbColor: BeatsColors.checkColor,
                    inactiveColor: BeatsColors.inputBgColor,

                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text("Area Radius", style:TextStyle(fontWeight: FontWeight.bold, color:BeatsColors.headingColor )),
                        Expanded(child: Container()),
                        Text("${areaRadius.toString()}m", style:TextStyle(fontWeight: FontWeight.bold, color:BeatsColors.headingColor )),
                      ],
                    ),
                  ),
              Slider(
                  onChangeEnd: (double value) {
                    widget.changeGreenRadius(value * 200);
                  },
                  value: widget.greenRadius > 200 ? 1 : (widget.greenRadius / 200),
                  onChanged: (double value) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      setState(() {
                        areaRadius = value;
                      });
                    });

                  },
                  label: widget.greenRadius.toString(),
                  activeColor: BeatsColors.inputBgColor,
                  thumbColor: BeatsColors.checkColor,
                  inactiveColor: BeatsColors.inputBgColor,
              ),


              ],
            ),
                ): Container(),
          );
        }),
      ],
    );
  }
}
