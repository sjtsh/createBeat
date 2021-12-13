import 'package:flutter/material.dart';

import '../OutletEntity.dart';

class OutletInfo extends StatelessWidget {
  final Outlet outlet;

  const OutletInfo(this.outlet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.network(
                outlet.img,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 40,
                left: 8,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 3,
                              spreadRadius: 3,
                              color: Colors.black.withOpacity(0.1))
                        ]),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ))
          ]),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 12,
                ),
                Column(
                  children: <List<String>>[
                    ["Beats Name", outlet.beatsName.toString()],
                    ["Beats Erp id", outlet.beatsERPID.toString()],
                    ["Distributor", outlet.distributor.toString()],
                    ["Outlets Name", outlet.outletsName.toString()],
                    ["Outlet Erp Id", outlet.outletERPID.toString()],
                    ["Owners Name", outlet.ownersName.toString()],
                    ["Owners Number", outlet.ownersNumber.toString()],
                    ["Formatted Address", outlet.formattedAddress.toString()],
                    ["Address", outlet.address.toString()],
                    ["SubCity", outlet.subCity.toString()],
                    ["Market", outlet.market.toString()],
                    ["City", outlet.city.toString()],
                    ["Zone", outlet.zone.toString()],
                    ["Region ", outlet.region.toString()],
                    ["Territory ", outlet.territory.toString()],
                    ["State", outlet.state.toString()],
                  ]
                      .map((e) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  children: [
                                    Text(
                                      e[0].toString(),
                                      maxLines: 3,
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      e[1].toString(),
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
