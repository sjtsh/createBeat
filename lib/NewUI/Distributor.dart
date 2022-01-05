import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';
import 'package:nearestbeats/GpxFileRead/GpxFileRead.dart';

import 'package:nearestbeats/data.dart';

class Distributor extends StatefulWidget {
  final List<Beat> beats;

  Distributor(this.beats);

  @override
  _DistributorState createState() => _DistributorState();
}

class _DistributorState extends State<Distributor> {
  int onDistributorTapped = -1;

  List aList = [];
  List aListForDisplay = [];
  TextEditingController controller = TextEditingController();

  distributorTap(int notTapped) {
    setState(() {
      onDistributorTapped = notTapped;
    });
  }

  String dropdownValue = "Unselected";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<Beat> myList = widget.beats
        .where((element) => allRegions.contains(element.region))
        .toList();
    aList = List.generate(myList.length, (index) => myList[index].distributor)
        .toSet()
        .toList();
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
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          Expanded(child: Container()),
                          const Text(
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller,
                      enableSuggestions: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xffF4F4F4),
                        filled: true,
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Color(0xff676767),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xff6DA7FE),
                            )),
                        hintText: "Search distributors",
                        hintStyle: const TextStyle(
                          color: Color(0xff676767),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (text) {
                        text = text.toLowerCase();
                        setState(() {
                          aListForDisplay = aList.where((element) {
                            var distributorName =
                                element.toString().toLowerCase();
                            return distributorName.contains(text);
                          }).toList();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Available Distributors",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff676767),
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "${controller.text == "" ? aList.length : aListForDisplay.length} Available",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff676767),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Builder(builder: (context) {
                        if (aListForDisplay.isNotEmpty ||
                            controller.text == "") {
                          return ListView.builder(
                            itemCount: controller.text == ""
                                ? aList.length
                                : aListForDisplay.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          color: Colors.black.withOpacity(0.1)),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            dropdownValue =
                                                controller.text == ""
                                                    ? aList[i] ?? "Unselected"
                                                    : aListForDisplay[i];
                                          });
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 38,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: (controller.text == "" &&
                                                        dropdownValue ==
                                                            aList[i]) ||
                                                    (controller.text != "" &&
                                                        dropdownValue ==
                                                            aListForDisplay[i])
                                                ? Color(0xff6C63FF)
                                                : Color(0xffE7E7E7),
                                          ),
                                          child: Icon(Icons.done,
                                              color: (controller.text == "" &&
                                                          dropdownValue ==
                                                              aList[i]) ||
                                                      (controller.text != "" &&
                                                          dropdownValue ==
                                                              aListForDisplay[
                                                                  i])
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              size: 24),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Flexible(
                                        child: Text(
                                          controller.text == ""
                                              ? aList[i]
                                              : aListForDisplay[i],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff676767),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text("No Search Results"),
                          );
                        }
                      }),
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
                    if (dropdownValue != "Unselected") {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GpxFileRead(dropdownValue);
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select Distributors"),
                            duration: Duration(seconds: 1)),
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      "SELECT DISTRIBUTOR",
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
