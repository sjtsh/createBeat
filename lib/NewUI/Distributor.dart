import 'package:flutter/material.dart';

import 'DistributorsList.dart';

class Distributor extends StatefulWidget {
  const Distributor({Key? key}) : super(key: key);

  @override
  _DistributorState createState() => _DistributorState();
}

class _DistributorState extends State<Distributor> {
  bool onDistributorTapped = false;

  distributorTap(bool notTapped) {
    setState(() {
      onDistributorTapped = !notTapped;
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
                          "20 Available",
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
                    Column(
                      children: ["", "", ""]
                          .map(
                            (e) => DistributorsList(
                                distributorTap, onDistributorTapped),
                          )
                          .toList(),
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
