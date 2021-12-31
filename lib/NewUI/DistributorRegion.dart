import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Methods/methods.dart';


import 'Distributor.dart';

class DistributorRegion extends StatefulWidget {
  const DistributorRegion({Key? key}) : super(key: key);

  @override
  _DistributorRegionState createState() => _DistributorRegionState();
}

class _DistributorRegionState extends State<DistributorRegion> {
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
    "Gandaki",
    "Lumbini",
    "Koshi",
    "Mechi",
    "Narayani",
    "Bagmati",
    "Janakpur",
  ];


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
                    SizedBox(
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
                        const Text(
                          "20 Available",
                          style: TextStyle(
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
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, mainAxisSpacing: 16),
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    height: 68,
                                    width: 68,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffCCCCCC),
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Text(getInitials(region[index]),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 36,
                                                color: Colors.white))),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    region[index],
                                    style: const TextStyle(
                                      color: Color(0xff676767),fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
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
