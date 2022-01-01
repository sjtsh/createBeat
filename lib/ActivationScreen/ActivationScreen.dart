import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Service/Auth.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:nearestbeats/GpxFileRead/GpxFileRead.dart';
import 'package:nearestbeats/NewUI/DistributorRegion.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ActivationScreen extends StatelessWidget {

  
  var authPin = "";

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
                          child: OTPTextField(
                            otpFieldStyle:OtpFieldStyle(backgroundColor: BeatsColors.inputBgColor,
                            ),
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 44,
                            style: TextStyle(
                                fontSize: 14
                            ),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.box,
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                              authPin = pin;
                            },
                          ),
                        )
                      ],
                    ),
        ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    AuthService()
                        .checkLogIn(
                      int.parse(authPin),
                    )
                        .then(
                          (value) {
                        if (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return const GpxFileRead();
                              },
                            ),
                          );
                          SharedPreferences.getInstance().then(
                                (prefs) => prefs.setInt(
                              "key",
                              int.parse(authPin),
                            ),
                          );
                        }
                      },
                    );
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


