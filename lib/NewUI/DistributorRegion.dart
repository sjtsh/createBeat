

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Components/colors.dart';

class DistributorRegion extends StatefulWidget {
  const DistributorRegion({Key? key}) : super(key: key);

  @override
  _DistributorRegionState createState() => _DistributorRegionState();
}

class _DistributorRegionState extends State<DistributorRegion> {
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
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                        ),
                        Expanded(child: Container()),
                        Text(
                          "Select Distributor Region",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      enableSuggestions: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xffDADADA),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: BeatsColors.greyColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xff6DA7FE),
                            )),
                        hintText: "Search here",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "2 Distributor Region Selected ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BeatsColors.textColor),
                    ),
                    SizedBox(height: 20,),
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
                                    decoration: BoxDecoration(
                                        color: BeatsColors.circularAvatar,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Text(index.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 36,
                                                color: Colors.white))),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Gandaki",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: BeatsColors.textColor),
                                  ),
                                )
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ),
              SizedBox(height: 2,),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return DistributorRegion();
                  }));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: BeatsColors.checkColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text("SELECT DISTRIBUTOR",

                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
