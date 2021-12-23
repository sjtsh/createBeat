import 'package:flutter/material.dart';

import '../data.dart';

class ConfirmScreen extends StatelessWidget {
  TextEditingController beat = TextEditingController();
  TextEditingController distributor = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  confirmAction() {
    Map aBody = {};
    outletsForBeat.forEach((element) {
      aBody[element.id] = {
        "beat": beat.text,
        "distributor": distributor.text,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3)
              ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Confirm",
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: distributor,
                      enableSuggestions: true,
                      validator: (dis) {
                        if (dis == null || dis.isEmpty) {
                          return 'Please enter Distributor';
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        hintText: "Distributor",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: beat,
                      enableSuggestions: true,
                      validator: (beat) {
                        if (beat == null || beat.isEmpty) {
                          return 'Please enter beat';
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xff6DA7FE))),
                        hintText: "Beat Name",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    /// List view

                    Expanded(
                        child: Column(
                            children:
                                List.generate(outletsForBeat.length, (index) {
                      for (var element in allOutlets) {
                        if (element.id == outletsForBeat[index]) {
                          return element;
                        }
                      }
                    }).map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 3,
                                    color: Colors.black.withOpacity(0.1),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (e?.outletsName.toString())??"unknown",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                         const SizedBox(
                            height: 6,
                          )
                        ],
                      );
                    }).toList())),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, bottom: 12),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.green,
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      child: Center(
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
