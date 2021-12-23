import 'package:sqflite/sqflite.dart';

import 'Backend/Entity/OutletEntity.dart';

class LocalDB {
  static var database;
  static createDB() async {
    var databasesPath = await getDatabasesPath();
    await deleteDatabase(databasesPath);
    database = await openDatabase(databasesPath, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Outlet(id INTEGER PRIMARY KEY, zone TEXT, region TEXT, territory TEXT, beatsName TEXT, beatsERPID TEXT, distributor TEXT, outletERPID TEXT, outletsName TEXT, '
          'lat REAL, lng REAL, ownersName TEXT, ownersNumber TEXT, formattedAddress TEXT, address TEXT, subCity TEXT, market TEXT, city TEXT, state TEXT, img TEXT)');
    });
  }

  static insertDB(Outlet outlet) async {
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Outlet(id, zone, region, territory, beatsName, beatsERPID, distributor, outletERPID, outletsName, lat, lng, ownersName, ownersNumber, formattedAddress, address, subCity, market, city, state, img) '
          'VALUES(${outlet.id},${outlet.zone},${outlet.region},${outlet.territory},${outlet.beatsName},${outlet.beatsERPID},${outlet.distributor},${outlet.outletERPID},${outlet.outletsName},${outlet.lat},${outlet.lng},${outlet.ownersName},${outlet.ownersNumber},${outlet.formattedAddress},${outlet.address},${outlet.subCity},${outlet.market},${outlet.city},${outlet.state},${outlet.img})');
      print('Inserted Outlet: $id1');
    });
  }
}
