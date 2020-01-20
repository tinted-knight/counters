import 'package:counter/model/CounterModel.dart';
import 'package:sqflite/sqflite.dart';

import 'DbProvider.dart';
import 'interface.dart';

class SQLiteStorageProvider implements ILocalStorage<CounterItem> {
  @override
  Future<bool> add(CounterItem item) async {
    var database = await DbProvider.db.database;
    return await database.insert(tableCounters, item.toMap()) >= 0;
  }

  @override
  Future<List<CounterItem>> getAll() async {
    var database = await DbProvider.db.database;
    var raw = await database.query(tableCounters);
    return raw.map((item) => CounterItem.fromMap(item)).toList();
  }

  @override
  Future<bool> update(CounterItem item) {
    print("repo::update");
    return Future.value(false);
  }
}
