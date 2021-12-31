import 'package:flutter/material.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:nearestbeats/NewUI/DistributorRegion.dart';

import 'ActivationCode.dart';

class ActivationScreen extends StatelessWidget {
  const ActivationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
              children: [
                Expanded(
                  child: ListView(
                   children:[ Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/activation.png"
                        ),
                          SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset(
                                  "assets/lock.png",
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 12,),
                              Text("Enter activation code",
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),

                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, right: 12, left: 12),
                          child: ActivationCode()
                        )
                      ],
                    ),
        ],
                  ),
                ),
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
                    child: Center(child: Text("ACTIVATE",

                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white),)),
                  ),
                ),
                SizedBox(height: 12,)
              ],
            ),
      ),
    );
  }
}
