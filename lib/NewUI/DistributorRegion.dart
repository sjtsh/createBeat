import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nearestbeats/Backend/Entity/Beat.dart';
import 'package:nearestbeats/Backend/Methods/methods.dart';
import 'package:nearestbeats/Backend/Service/BeatService.dart';
import 'package:nearestbeats/Components/colors.dart';

import '../data.dart';

import 'Distributor.dart';

class DistributorRegion extends StatefulWidget {
  final List<String> regions;
  final List<Beat> beats;
  final Function refresh;

  const DistributorRegion(this.regions, this.beats, this.refresh);

  @override
  _DistributorRegionState createState() => _DistributorRegionState();
}

class _DistributorRegionState extends State<DistributorRegion> {

  String available = "0";

  List<bool> value = [];

  checkbox(int index, bool isChecked) {
    setState(() {
      value[index] = isChecked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //value = List.generate(region.length, (index) => false);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    height: 35,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                        ),
                        Expanded(child: Container()),
                        const Text(
                          "Select Distributor Region",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextFormField(
                      enableSuggestions: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        fillColor: const Color(0xffF4F4F4),
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
                        hintText: "Search distributor region",
                        hintStyle: const TextStyle(
                          color: Color(0xff676767),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ),
                  allRegions.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(

                                children: [
                                  const Text(
                                    "Selected Regions",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff676767),
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Text(

                                    "${allRegions.length} Available",

                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff676767),
                                    ),
                                  ),
                                ],
                              ),

                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                children: allRegions
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: 6.0, bottom: 6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF4F4F4),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset:
                                                        const Offset(0, 2))
                                              ]),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                allRegions.remove(e);
                                                widget.refresh();
                                              },
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                direction: Axis.horizontal,
                                                children: [
                                                  Text(
                                                    e,
                                                    style: const TextStyle(
                                                      color: BeatsColors.headingColor,

                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(
                                                    Icons.clear,
                                                    size: 12,
                                                    color: BeatsColors.headingColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Divider(
                                color: Colors.black.withOpacity(0.1),
                                thickness: 1.5,
                                height: 1.5,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        const Text(
                          "Available Regions",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: BeatsColors.headingColor,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "${widget.regions.length} available",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: BeatsColors.headingColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, mainAxisSpacing: 16,),
                          itemCount: widget.regions.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8,),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (allRegions
                                          .contains(widget.regions[index])) {
                                        allRegions
                                            .remove(widget.regions[index]);
                                      } else {
                                        allRegions.add(widget.regions[index]);
                                      }
                                      widget.refresh();
                                    },
                                    child: allRegions
                                            .contains(widget.regions[index])
                                        ? Container(
                                            height: 66,
                                            width: 66,
                                            decoration: const BoxDecoration(
                                                color: BeatsColors.checkColor,
                                                shape: BoxShape.circle),
                                            child: const Center(
                                                child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )),
                                          )
                                        : Container(
                                            height: 66,
                                            width: 66,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffCCCCCC),
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: Text(
                                                    getInitials(
                                                        widget.regions[index]),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 36,
                                                        color: Colors.white))),
                                          ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    widget.regions[index],
                                    style: const TextStyle(
                                        color: BeatsColors.headingColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff6C63FF),
                    borderRadius: BorderRadius.circular(6)),
                child: MaterialButton(
                  onPressed: () {
                    print(allRegions);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Distributor(widget.beats);
                    }));
                  },
                  child: const Center(
                      child: Text(
                    "SELECT DISTRIBUTOR REGION",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
