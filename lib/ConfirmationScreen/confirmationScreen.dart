import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/OutletEntity.dart';
import 'package:nearestbeats/Backend/Service/OutletService.dart';
import 'package:nearestbeats/Components/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data.dart';

class ConfirmationScreen extends StatefulWidget {
  final String distributorName;
  final String beatName;
  final Function setMarkerRed;
  final Function changeRadius;

  ConfirmationScreen(
    this.distributorName,
    this.beatName,
    this.setMarkerRed,
    this.changeRadius,
  );

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  TextEditingController beat = TextEditingController();

  TextEditingController distributor = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isDisabled = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    beat.text = widget.beatName;
    distributor.text = widget.distributorName;
  }

  @override
  Widget build(BuildContext context) {
    print("building on coonfirmation screen");
    List<Outlet?> toListOutlets =
        List.generate(outletsForBeat.toSet().length, (index) {
      for (var element in allOutlets) {
        if (element.id == outletsForBeat[index]) {
          return element;
        }
      }
    }).toSet().toList();

    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: toListOutlets.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "Confirm Beat",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: Container())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Distributor Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: BeatsColors.headingColor),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                controller: distributor,
                                enableSuggestions: true,
                                validator: (dis) {
                                  if (dis == null || dis.isEmpty) {
                                    return "Please enter Distributor name";
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  fillColor: BeatsColors.inputBgColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: BeatsColors.greyColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: BeatsColors.inputBorderColor,
                                      )),
                                  hintText: "Distributor name",
                                  hintStyle: TextStyle(
                                    color: BeatsColors.headingColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Beat Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: BeatsColors.headingColor),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                controller: beat,
                                validator: (beat) {
                                  if (beat == null || beat.isEmpty) {
                                    return "Please enter beat name";
                                  }
                                },
                                enableSuggestions: true,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  fillColor: BeatsColors.inputBgColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: BeatsColors.greyColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: BeatsColors.inputBorderColor,
                                      )),
                                  hintText: "Beat name",
                                  hintStyle: TextStyle(
                                    color: BeatsColors.headingColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 12,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text(
                                "Outlets",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: BeatsColors.headingColor),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "${toListOutlets.length} Selected",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: BeatsColors.headingColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 3,
                                color: BeatsColors.greyColor)
                          ]),
                      child: Row(
                        children: [
                          Image.network(
                            (toListOutlets[index]?.img) ?? "",
                            errorBuilder: (BuildContext context,
                                Object exception,
                                StackTrace? stackTrace) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Couldn't load" ),
                              ),
                                );
                            },
                            fit: BoxFit.cover,
                            width: 120,

                          ),

                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(

                                  toListOutlets[index - 1]!.outletsName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: BeatsColors.headingColor),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  (toListOutlets[index - 1]!
                                      .ownersNumber
                                      .toString()),
                                  style: const TextStyle(
                                      color: BeatsColors.headingColor),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: 110,
                                  height: 26,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: BeatsColors.checkColor),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          if (toListOutlets[index] != null) {
                                            launch(
                                                'https://www.google.com/maps/search/?api=1&query=${toListOutlets[index]?.lat},${toListOutlets[index]?.lng}');
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 3,
                                              bottom: 3,
                                              right: 8,
                                              left: 8),
                                          child: Builder(builder: (context) {
                                            return const Center(
                                              child: Text(
                                                "VIEW ON MAPS",
                                                style: TextStyle(
                                                    color:
                                                        BeatsColors.checkColor,
                                                    fontSize: 12),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: BeatsColors.closeColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      outletsForBeat.remove(toListOutlets[index]?.id);
                                       widget.setMarkerRed((toListOutlets[index]?.id) ?? 0);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            MaterialButton(
              onPressed: () {
                {
                  if (_formKey.currentState!.validate() && !isDisabled) {
                    setState(() {
                      isDisabled = true;
                    });

                    Map<String, Map<String, String>> aBody = {};
                    for (var element in outletsForBeat) {
                      aBody[element.toString()] = {
                        "beat": beat.text,
                        "distributor": distributor.text,
                      };
                    }
                    OutletService().updateOutlet(context, aBody).then(
                      (value) {
                        allOutlets = [];
                        outletsForBeat = [];
                        List<bool> bool1s =
                            List.generate(allRegions.length, (index) => false);
                        for (int i = 0; i < allRegions.length; i++) {
                          OutletService()
                              .fetchOutlet(context, allRegions[i])
                              .then((value) {
                            allOutlets.addAll(value);
                            bool1s[i] = true;
                            if (!bool1s.contains(false)) {
                              widget.changeRadius(1000.0);
                              setState(() {
                                isDisabled = false;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upadate successfull")));
                            }
                          });
                        }
                      },
                    );
                  }
                }
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: BeatsColors.checkColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: isDisabled
                        ? CircularProgressIndicator()
                        : Text(
                            "UPDATE NEW BEAT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
              ),
            ),
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    ));
  }
}
