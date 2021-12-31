import 'package:flutter/material.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ActivationCode extends StatelessWidget {
  const ActivationCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:50 ,
      width: double.infinity,

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
        },
      ),
    );
  }
}
