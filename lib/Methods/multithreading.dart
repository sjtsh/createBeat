import '../OutletEntity.dart';
import '../data.dart';

// class Argument {
//   final int startPoint;
//   final int endPoint;
//
//   Argument(this.startPoint, this.endPoint);
// }

// void multithreading() {
//   int computations = allDataLocal.length;
//   int remainder = computations % threadCount;
//   List<int> slicing = [];
//
//   for (int i = 0; i < threadCount; i++) {
//     slicing.add(computations ~/ threadCount);
//   }
//   for (int i = 0; i < remainder; i++) {
//     slicing[i] += 1;
//   }
//
//   for (int i = 0; i < threadCount; i++) {
//     int startPoint, endPoint;
//     if (i == 0) {
//       startPoint = 0;
//     } else {
//       startPoint = arguments[i - 1].endPoint + 1;
//     }
//     endPoint = startPoint + slicing[i] - 1;
//     arguments.add(Argument(startPoint, endPoint));
//   }
// }

