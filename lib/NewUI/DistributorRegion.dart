import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Methods/methods.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';

import '../data.dart';

import 'Distributor.dart';

class DistributorRegion extends StatefulWidget {
  const DistributorRegion({Key? key}) : super(key: key);

  @override
  _DistributorRegionState createState() => _DistributorRegionState();
}

class _DistributorRegionState extends State<DistributorRegion> {
  List<Beat> beats = [];
  List<Beat> selectedBeats = [];

  String available = "0";

  List region = [
    "Gandaki",
    "Lumbini",
    "Koshi",
    "Mechi",
    "Narayani",
    "Bagmati",
    "Janakpur",
    "Bheri",
    "Seti",
    "Sagarmatha",
    "Karnali",
    "Mahakali",
    "Rara",
    "Uandaki",
    "Pumbini",
    "Eoshi",
    "pechi",
    "Parayani",
    "Bfagmati",
    "Jafnakpur",
  ];
  List<bool> value = [];

  tap() {
    checkedDetails = [];
    region.forEach((element) {
      if (value[region.indexOf(element)]) {
        checkedDetails.add(element);
      }
    });
  }

  checkbox(int index, bool isChecked) {
    setState(() {
      value[index] = isChecked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = List.generate(region.length, (index) => false);
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
                          Icon(
                            Icons.arrow_back,
                          ),
                          Expanded(child: Container()),
                          Text(
                            "Select Distributor Region",
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        fillColor: const Color(0xffF4F4F4),
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
                        hintText: "Search distributor region",
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
                          "Available Regions",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff676767),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "$available available",
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
                      child: FutureBuilder(
                          future:
                              BeatService().fetchBeats(context).then((value) {
                            return value;
                          }),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List<String> myRegions = [];
                              beats = snapshot.data;

                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((_) {
                                setState(() {
                                  available = myRegions.length.toString();
                                });
                              });

                              beats.forEach((element) {
                                if (!myRegions.contains(element.region)) {
                                  myRegions.add(element.region);
                                }
                              });
                              return GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 16),
                                  itemCount: myRegions.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Container(
                                            height: 66,
                                            width: 66,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffCCCCCC),
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: Text(
                                                    getInitials(
                                                        myRegions[index]),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 36,
                                                        color: Colors.white))),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            myRegions[index],
                                            style: const TextStyle(
                                                color: Color(0xff676767),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }
                            return  const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    )
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Distributor();
                    }));
                  },
                  child: const Center(
                      child: Text(
                    "SELECT DISTRIBUTOR REGION",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
