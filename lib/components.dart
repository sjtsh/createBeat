import 'package:nearestbeats/data.dart';

import 'Backend/Entity/Beat.dart';

String getInitials(String name){
  if (name.split(" ").length >= 2) {
    return name.split(" ")[0].substring(0, 1).toUpperCase() +
        name.split(" ")[1].substring(0, 1).toUpperCase();
  } else if (name.split(" ").length == 1) {
    return name.split(" ")[0].substring(0, 1).toUpperCase();
  } else {
    return "-";
  }
}
