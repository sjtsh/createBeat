import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';
import 'package:nearestbeats/GpxFileRead/GpxFileRead.dart';


import 'package:nearestbeats/data.dart';

import 'DistributorsList.dart';

class Distributor extends StatefulWidget {
  final List<Beat> beats;

  Distributor(this.beats);

  @override
  _DistributorState createState() => _DistributorState();
}

class _DistributorState extends State<Distributor> {
  int onDistributorTapped = -1;

  String totalDistributor = "0";

  distributorTap(int notTapped) {
    setState(() {
      onDistributorTapped = notTapped;
    });
  }

  String dropdownValue = "Unselected";

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
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          Expanded(child: Container()),
                          const Text(
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enableSuggestions: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xffF4F4F4),
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Color(0xff676767),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xff6DA7FE),
                            )),
                        hintText: "Search distributors",
                        hintStyle: const TextStyle(
                          color: Color(0xff676767),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Available Distributors",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff676767),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "$totalDistributor Available",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff676767),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Builder(builder: (context) {
                        List<Beat> myList = widget.beats
                            .where((element) =>
                                allRegions.contains(element.region))
                            .toList();
                        List aList = List.generate(myList.length,
                                (index) => myList[index].distributor)
                            .toSet()
                            .toList();
                       WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                         setState(() {
                           totalDistributor = aList.length.toString();
                         });
                       });
                        return ListView.builder(
                          itemCount: aList.length,
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
                                        color: Colors.black.withOpacity(0.1)),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          dropdownValue =
                                              aList[i] ?? "Unselected";
                                        });

                                      },
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: dropdownValue == aList[i]
                                              ? Color(0xff6C63FF)
                                              : Color(0xffE7E7E7),
                                        ),
                                        child: Icon(Icons.done,
                                            color: dropdownValue == aList[i]
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
                                        aList[i],
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
                          },
                        );
                      }),
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


                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return GpxFileRead(dropdownValue);

                    }));
                  },
                  child: Center(
                    child: Text(
                      "SELECT DISTRIBUTOR",
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
