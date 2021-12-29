import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Service/Auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GpxFileRead/GpxFileRead.dart';

class ActivationScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                controller: controller,
                decoration: const InputDecoration(
                  label: Text("CODE"),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  AuthService()
                      .checkLogIn(
                    int.parse(controller.text),
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
                            int.parse(controller.text),
                          ),
                        );
                      }
                    },
                  );
                },
                child: Center(
                  child: Text("NEXT", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
