import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';
import 'package:nearestbeats/data.dart';

import 'DistributorsList.dart';

class Distributor extends StatefulWidget {
  const Distributor({Key? key}) : super(key: key);

  @override
  _DistributorState createState() => _DistributorState();
}

class _DistributorState extends State<Distributor> {
  int onDistributorTapped = -1 ;
  String totalDistributor = "0";
  List<Beat> beats = [];



  distributorTap(int notTapped) {
    setState(() {
      onDistributorTapped = notTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            "Select Distributor",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enableSuggestions: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xffF4F4F4),
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xff676767),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xff6DA7FE),
                            )),
                        hintText: "Search distributors",
                        hintStyle: TextStyle(
                          color: Color(0xff676767),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Available Distributors",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff676767),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "$totalDistributor Available",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff676767),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Column(
                    //   children: [
                    //     ["05- Saaru Enterprises- Pokhara", 0],
                    //     ["05- Saaru Enterprises- Pokhara", 1],
                    //     ["05- Saaru Enterprises- Pokhara", 2]
                    //   ]
                    //       .map(
                    //         (e) => Column(
                    //           children: [
                    //             Container(
                    //               height: 60,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(6),
                    //                 color: Colors.white,
                    //                 boxShadow: [
                    //                   BoxShadow(
                    //                       offset: Offset(0, 2),
                    //                       blurRadius: 1,
                    //                       spreadRadius: 1,
                    //                       color: Colors.black.withOpacity(0.1)),
                    //                 ],
                    //               ),
                    //               child: Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 12,
                    //                   ),
                    //                   InkWell(
                    //                     onTap: () {
                    //                       distributorTap(e[1] as int);
                    //                     },
                    //                     child: Container(
                    //                       height: 38,
                    //                       width: 38,
                    //                       decoration: BoxDecoration(
                    //                         shape: BoxShape.circle,
                    //                         color: onDistributorTapped == e[1]
                    //                             ? Color(0xff6C63FF)
                    //                             : Color(0xffE7E7E7),
                    //                       ),
                    //                       child: Icon(Icons.done,
                    //                           color: onDistributorTapped == e[1]
                    //                               ? Colors.white
                    //                               : Colors.transparent,
                    //                           size: 24),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     width: 12,
                    //                   ),
                    //                   Text(
                    //                     e[0] as String,
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.w500,
                    //                       color: Color(0xff676767),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 12,
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //       .toList(),
                    // ),

                    Expanded(
                      child: FutureBuilder(
                        future: BeatService().fetchBeats(context).then((value) {
                          return value;
                        }),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {

                            beats = snapshot.data;
                            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                              setState(() {
                                totalDistributor = beats.length.toString();
                              });
                            });
                          }


                          return ListView.builder(
                              itemCount: beats.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                            color:
                                                Colors.black.withOpacity(0.1)),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 12,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            distributorTap(i);
                                            //  setState(() {
                                            //    seclectedIndex = i;
                                            //  });
                                          },
                                          child: Container(
                                            height: 38,
                                            width: 38,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: onDistributorTapped == i
                                                  ? Color(0xff6C63FF)
                                                  : Color(0xffE7E7E7),
                                            ),
                                            child: Icon(Icons.done,
                                                color: onDistributorTapped == i
                                                    ? Colors.white
                                                    : Colors.transparent,
                                                size: 24),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Flexible(
                                          child: Text(
                                            beats[i].distributor,

                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff676767),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff6C63FF),
                    borderRadius: BorderRadius.circular(6)),
                child: MaterialButton(
                  onPressed: () {
                    print(checkedDetails);
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return DistributorRegion();
                    // }));
                  },
                  child: Center(
                    child: Text(
                      "SELECT ROUTES",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
