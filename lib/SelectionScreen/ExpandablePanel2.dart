// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:nearestbeats/Backend/Entity/Beat.dart';
//
// import '../data.dart';
// import 'SelectionScreen.dart';
//
// class ExpandablePanel2 extends StatefulWidget {
//   final String distributor;
//   final String region;
//   final Function expanded;
//   final String currentlyExpanded;
//   final List<Beat> myBeats;
//   final Function refresh;
//   final bool isAlreadySelected;
//
//   ExpandablePanel2(
//       this.distributor,
//       this.region,
//       this.expanded,
//       this.currentlyExpanded,
//       this.myBeats,
//       this.refresh,
//       this.isAlreadySelected);
//
//   @override
//   State<ExpandablePanel2> createState() => _ExpandablePanel2State();
// }
//
// class _ExpandablePanel2State extends State<ExpandablePanel2> {
//   final ExpandableController _expandableControllerBase = ExpandableController();
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.currentlyExpanded == widget.distributor) {
//       _expandableControllerBase.expanded = true;
//     } else {
//       _expandableControllerBase.expanded = false;
//     }
//     return ExpandablePanel(
//       controller: _expandableControllerBase,
//       collapsed: Padding(
//         padding: const EdgeInsets.only(top: 4, bottom: 4),
//         child: Container(
//           clipBehavior: Clip.hardEdge,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.black.withOpacity(0.1)),
//           ),
//           child: InkWell(
//             onTap: () {
//               widget.expanded(widget.distributor);
//               _expandableControllerBase.expanded =
//                   !_expandableControllerBase.expanded;
//             },
//             child: Container(
//               width: double.infinity,
//               color: widget.isAlreadySelected ? Colors.green : Colors.white,
//               padding: EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       widget.distributor,
//                       style: TextStyle(
//                           color: widget.isAlreadySelected
//                               ? Colors.white
//                               : Colors.black),
//                     ),
//                   ),
//                   Icon(Icons.keyboard_arrow_down_sharp,
//                       color: widget.isAlreadySelected
//                           ? Colors.white
//                           : Colors.black),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       expanded: Padding(
//         padding: const EdgeInsets.only(top: 4, bottom: 4),
//         child: Container(
//           clipBehavior: Clip.hardEdge,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.black.withOpacity(0.1)),
//           ),
//           child: InkWell(
//             onTap: () {
//               widget.expanded(widget.distributor);
//               _expandableControllerBase.expanded =
//                   !_expandableControllerBase.expanded;
//             },
//             child: Container(
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   Container(
//                     color:
//                         widget.isAlreadySelected ? Colors.green : Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Builder(builder: (context) {
//                             bool distributorValue = true;
//                             widget.myBeats
//                                 .where((element) =>
//                                     element.distributor == widget.distributor)
//                                 .forEach((element) {
//                               bool isHere = false;
//                               for (Beat i in selectedBeats) {
//                                 if (i.region == widget.region &&
//                                     i.distributor == widget.distributor &&
//                                     element.beat == i.beat) {
//                                   isHere = true;
//                                   break;
//                                 }
//                               }
//                               if (!isHere) {
//                                 distributorValue = false;
//                               }
//                             });
//                             return Checkbox(
//                               value: distributorValue,
//                               onChanged: (newstatus) {
//                                 if (newstatus!) {
//                                   widget.myBeats
//                                       .where((element) =>
//                                           element.distributor ==
//                                           widget.distributor)
//                                       .forEach((element) {
//                                     bool isHere = false;
//                                     for (Beat i in selectedBeats) {
//                                       if (i.region == widget.region &&
//                                           i.distributor == widget.distributor &&
//                                           element.beat == i.beat) {
//                                         isHere = true;
//                                         break;
//                                       }
//                                     }
//                                     if (!isHere) {
//                                       selectedBeats.add(element);
//                                     }
//                                   });
//                                 } else {
//                                   widget.myBeats
//                                       .where((element) =>
//                                           element.distributor ==
//                                           widget.distributor)
//                                       .forEach((element) {
//                                     bool isHere = false;
//                                     for (Beat i in selectedBeats) {
//                                       if (i.region == widget.region &&
//                                           i.distributor == widget.distributor &&
//                                           element.beat == i.beat) {
//                                         isHere = true;
//                                         break;
//                                       }
//                                     }
//                                     if (isHere) {
//                                       selectedBeats.removeWhere((i) =>
//                                           i.region == widget.region &&
//                                           i.distributor == widget.distributor &&
//                                           element.beat == i.beat);
//                                     }
//                                   });
//                                 }
//                                 widget.refresh();
//                               },
//                             );
//                           }),
//                           Expanded(
//                               child: Text(
//                             widget.distributor,
//                             style: TextStyle(
//                               color: widget.isAlreadySelected
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           )),
//                           Icon(Icons.keyboard_arrow_up,
//                               color: widget.isAlreadySelected
//                                   ? Colors.white
//                                   : Colors.black)
//                         ],
//                       ),
//                     ),
//                   ),
//                   widget.isAlreadySelected
//                       ? Container()
//                       : const Divider(
//                           color: Colors.black,
//                         ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Builder(builder: (context) {
//                       List<Beat> beats = [];
//                       widget.myBeats
//                           .where((element) =>
//                               element.distributor == widget.distributor)
//                           .forEach((element) {
//                         if (!beats.contains(element)) {
//                           beats.add(element);
//                         }
//                       });
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: beats
//                             .map(
//                               (f) => Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       f.beat,
//                                       maxLines: 3,
//                                     ),
//                                   ),
//                                   Builder(builder: (context) {
//                                     bool value = false;
//                                     for (var element in selectedBeats) {
//                                       if (element.distributor ==
//                                               f.distributor &&
//                                           element.region == f.region &&
//                                           element.beat == f.beat) {
//                                         value = true;
//                                       }
//                                     }
//                                     return Checkbox(
//                                       value: value,
//                                       onChanged: (newstatus) {
//                                         if (newstatus ?? false) {
//                                           setState(() {
//                                             selectedBeats.add(f);
//                                             print(selectedBeats);
//                                           });
//                                         } else {
//                                           setState(() {
//                                             selectedBeats.remove(f);
//                                             print(selectedBeats);
//                                           });
//                                         }
//                                         widget.refresh();
//                                       },
//                                     );
//                                   }),
//                                 ],
//                               ),
//                             )
//                             .toList(),
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
