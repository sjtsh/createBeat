import 'package:flutter/material.dart';
import 'package:nearestbeats/Components/colors.dart';

import 'DistributorRegion.dart';

class DistributorList extends StatefulWidget {
  const DistributorList({Key? key}) : super(key: key);

  @override
  _DistributorListState createState() => _DistributorListState();
}

class _DistributorListState extends State<DistributorList> {
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
                    SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Step 1 of 3 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BeatsColors.textColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
          Row(
          children: [
          Container(
          height: 5,
            width: 100,
            decoration: BoxDecoration(
                color: BeatsColors.checkColor,
                borderRadius: BorderRadius.circular(7)),
          ),
          Expanded(child: Container()),
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
                color: BeatsColors.greyColor,
                borderRadius: BorderRadius.circular(7)),
          ),
          Expanded(child: Container()),
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
                color: BeatsColors.greyColor,
                borderRadius: BorderRadius.circular(7)),
          )
          ],
        ),
                    SizedBox(height: 40,),

                    Row(
                      children: [
                        Text(
                          "Choose Distributor Region ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: BeatsColors.textColor),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "1 Selected ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: BeatsColors.textColor),
                        ),
                      ],
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
