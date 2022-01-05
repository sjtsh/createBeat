import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Service/Auth.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:nearestbeats/GpxFileRead/GpxFileRead.dart';
import 'package:nearestbeats/NewUI/DistributorRegion.dart';
import 'package:nearestbeats/NewUI/futureDistributorRegion.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivationScreen extends StatefulWidget {
  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  var authPin = "";

  bool isPinMatched = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/activation.png",
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/lock.png",
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Enter activation code",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, right: 12, left: 12),
                        child: OTPTextField(
                          otpFieldStyle: OtpFieldStyle(
                            backgroundColor: BeatsColors.inputBgColor,
                          ),
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 44,
                          style: TextStyle(fontSize: 14),
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
                if (authPin.isNotEmpty && authPin.length == 6) {
                  setState(() {
                    isPinMatched = true;
                  });

                  AuthService()
                      .checkLogIn(
                    int.parse(authPin),
                  )
                      .then(
                    (value) {
                      if (value == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return const FutureDistributorRegion();
                            },
                          ),
                        );
                        SharedPreferences.getInstance().then(
                          (prefs) => prefs.setInt(
                            "key",
                            int.parse(authPin),
                          ),
                        );
                      } else {
                        setState(() {
                          isPinMatched = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Invalid Authentication Code")));
                      }
                    },
                  );
                } else {
                  setState(() {
                    isPinMatched = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter Authentication Code")));
                }
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: BeatsColors.checkColor,
                    borderRadius: BorderRadius.circular(12)),
                child: isPinMatched == false
                    ? const Center(
                        child: Text(
                        "ACTIVATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
