import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/OutletEntity.dart';
import 'package:nearestbeats/Backend/Service/OutletService.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data.dart';

class ConfirmationScreen extends StatefulWidget {
  final String distributorName;
  final String beatName;
  final Function setMarkerRed;

  ConfirmationScreen(this.distributorName, this.beatName, this.setMarkerRed);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  TextEditingController beat = TextEditingController();

  TextEditingController distributor = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  bool isDisabled = false;
  List<Outlet?> toListOutlets= [];

  void initState() {
    // TODO: implement initState
    super.initState();
    beat.text = widget.beatName;
    distributor.text = widget.distributorName;

 toListOutlets =
    List.generate(outletsForBeat.toSet().length, (index) {
      for (var element in allOutlets) {
        print("confirmation ma $allOutlets");
        if (element.id == outletsForBeat[index]) {
          return element;
        }
      }
    }).toSet().toList();
  }


  @override
  Widget build(BuildContext context) {






    List<String> listo = ["one", "two","three", "four","five", "six","seven", "eight","nine", "ten","twelve", "thirteen"];





    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  print("456 $toListOutlets");
                  if (index == 0) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "Confirm Beat",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: Container())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Distributor Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: BeatsColors.headingColor),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                controller: distributor,
                                enableSuggestions: true,
                                validator: (dis){
                                  if(dis==null|| dis.isEmpty){
                                    return "Please enter Distributor name";
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  fillColor: BeatsColors.inputBgColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: BeatsColors.greyColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: BeatsColors.inputBorderColor,
                                      )),
                                  hintText: "Distributor name",
                                  hintStyle: TextStyle(
                                    color: BeatsColors.headingColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Beat Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: BeatsColors.headingColor),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                controller: beat,
                                validator: (beat) {
                                  if (beat == null || beat.isEmpty){
                                    return "Please enter beat name";
                                  }
                                },
                                enableSuggestions: true,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  fillColor: BeatsColors.inputBgColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: BeatsColors.greyColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: BeatsColors.inputBorderColor,
                                      )),
                                  hintText: "Beat name",
                                  hintStyle: TextStyle(
                                    color: BeatsColors.headingColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 12,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text(
                                "Outlets",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: BeatsColors.headingColor),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "3 Selected",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: BeatsColors.headingColor),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 12, right: 12, bottom: 8),
                        //   child: Container(
                        //     height: 100,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(6),
                        //         boxShadow: [
                        //           BoxShadow(
                        //               offset: Offset(0, 2),
                        //               blurRadius: 3,
                        //               color: BeatsColors.greyColor)
                        //         ]),
                        //     child: Row(
                        //       children: [
                        //         Image.asset("assets/activation.png"),
                        //         Expanded(child: Container()),
                        //         Padding(
                        //           padding: const EdgeInsets.all(12.0),
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Kulekhani Cold Store $index",
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.bold,
                        //                     color: BeatsColors.headingColor),
                        //               ),
                        //               SizedBox(
                        //                 height: 3,
                        //               ),
                        //               Text(
                        //                 "984321237$index",
                        //                 style: TextStyle(
                        //                     color: BeatsColors.headingColor),
                        //               ),
                        //               SizedBox(
                        //                 height: 8,
                        //               ),
                        //               Container(
                        //                 width: 110,
                        //                 height: 26,
                        //                 clipBehavior: Clip.hardEdge,
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(12),
                        //                 ),
                        //                 child: Material(
                        //                   color: Colors.white,
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(12),
                        //                       border: Border.all(
                        //                           color: BeatsColors.checkColor),
                        //                     ),
                        //                     child: InkWell(
                        //                       onTap: () {
                        //                         // if (e != null) {
                        //                         //   launch(
                        //                         //       'https://www.google.com/maps/search/?api=1&query=${e.lat},${e.lng}');
                        //                         // }
                        //                       },
                        //                       child: Container(
                        //                         margin: EdgeInsets.only(
                        //                             top: 3,
                        //                             bottom: 3,
                        //                             right: 8,
                        //                             left: 8),
                        //                         child:
                        //                             Builder(builder: (context) {
                        //                           return Center(
                        //                             child: Text(
                        //                               "VIEW ON MAPS",
                        //                               style: TextStyle(
                        //                                   color: BeatsColors
                        //                                       .checkColor,
                        //                                   fontSize: 12),
                        //                             ),
                        //                           );
                        //                         }),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Expanded(child: Container()),
                        //         Padding(
                        //           padding: const EdgeInsets.only(right: 16),
                        //           child: Container(
                        //             decoration: const BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               color: BeatsColors.closeColor,
                        //             ),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(2.0),
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   /// on tap funtion
                        //                 },
                        //                 child: Icon(
                        //                   Icons.close,
                        //                   color: Colors.white,
                        //                   size: 14,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  }

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 3,
                                color: BeatsColors.greyColor)
                          ]),
                      child: Row(
                        children: [
                          Image.asset("assets/activation.png"),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 // allOutlets[index-1]!.outletsName,
                                  listo[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: BeatsColors.headingColor),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  //(allOutlets[index-1]!.ownersNumber.toString()),
                                  "984321237$index",
                                  style:
                                      TextStyle(color: BeatsColors.headingColor),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: 110,
                                  height: 26,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: BeatsColors.checkColor),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // if (e != null) {
                                          //   launch(
                                          //       'https://www.google.com/maps/search/?api=1&query=${e.lat},${e.lng}');
                                          // }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 3,
                                              bottom: 3,
                                              right: 8,
                                              left: 8),
                                          child: Builder(builder: (context) {
                                            return Center(
                                              child: Text(
                                                "VIEW ON MAPS",
                                                style: TextStyle(
                                                    color: BeatsColors.checkColor,
                                                    fontSize: 12),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: BeatsColors.closeColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                         // outletsForBeat.remove(e?.id);
                                         //  widget.setMarkerRed((e?.id) ?? 0);
                                      print("k vako hola confirm");
                                      print(toListOutlets);
                                      for (int i =0; i<allOutlets.length; i++){
                                        print ("confirm ${allOutlets[i].outletsName}");
                                      }
                                        });                                     },

                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            MaterialButton(
              onPressed: () {
                {
                  if (_formKey.currentState!.validate() && !isDisabled) {
                    setState(() {
                      isDisabled = true;
                    });

                    Map<String, Map<String, String>> aBody = {};
                    for (var element in outletsForBeat) {
                      aBody[element.toString()] = {
                        "beat": beat.text,
                        "distributor": distributor.text,
                      };
                    }
                    OutletService()
                        .updateOutlet(context, aBody)
                        .then((value) {
                      setState(() {
                        isDisabled = false;
                        outletsForBeat = [];
                        allRegions = [];
                        allOutlets = [];
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) {
                        //       return GpxFileRead();
                        //     }));
                      });
                    });
                  }
                }
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: BeatsColors.checkColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: isDisabled ? CircularProgressIndicator():Text(
                  "UPDATE NEW BEAT",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    ));
  }
}
