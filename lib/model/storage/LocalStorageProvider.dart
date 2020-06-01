import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/model/datetime.dart';
import 'package:sqflite/sqflite.dart';

import 'DbProvider.dart';
import 'interface.dart';

class SQLiteStorageProvider implements ILocalStorage<CounterItem> {
  Future<Database> connection() async {
    return DbProvider.db.database;
  }

  @override
  Future<int> add(CounterItem item) async {
    final database = await connection();
    return await database.insert(tableCounters, item.toMap());
  }

  @override
  Future<List<CounterItem>> getAll() async {
    final database = await connection();
    final raw = await database.query(tableCounters);
    return raw.map((item) => CounterItem.fromMap(item)).toList();
  }

  @override
  Future<bool> update(CounterItem item) async {
    final database = await connection();
    final result = await database.update(
      tableCounters,
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
    return result > 0;
  }

  @override
  Future<bool> delete(CounterItem item) async {
    final database = await connection();
    final deleted = await database.delete(
      tableCounters,
      where: "id = ?",
      whereArgs: [item.id],
    );
    return deleted > 0;
  }

  @override
  Future<bool> insertHistory(int id, int value, int timestamp) async {
//    final ts = DateTime.fromMillisecondsSinceEpoch(timestamp);
//    final dt = DateTime(ts.year, ts.month, ts.day).millisecondsSinceEpoch;
    final dt = datetime(from: timestamp);
    final insertData = {
      colCounterId: id,
      colDate: dt,
      colValue: value,
    };
    final database = await connection();
    final result = await database.insert(tableHistory, insertData);
    return result > 0;
  }

  @override
  Future<bool> updateExisting(int id, int value) async {
//    final ts = DateTime.fromMillisecondsSinceEpoch(timestamp);
//    final dt = DateTime(ts.year, ts.month, ts.day).millisecondsSinceEpoch;
    final database = await connection();
    final result = await database.update(
      tableHistory,
      {
        colCounterId: id,
//        colDate: dt,
        colValue: value,
      },
      where: "$colCounterId = ?",
      whereArgs: [id],
    );
    return result > 0;
  }

  Future<bool> updateExistingHistoryItem(HistoryModel item) async {
    final database = await connection();
    final result = await database.update(
      tableHistory,
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
    return result > 0;
  }

  @override
  Future<List<HistoryModel>> getHistoryFor({CounterItem counter}) async {
    final database = await connection();
    final raw = await database.query(
      tableHistory,
      where: "$colCounterId = ?",
      whereArgs: [counter.id],
      orderBy: "$colDate desc",
    );
    return raw.map((item) => HistoryModel.fromMap(item)).toList();
  }

  @override
  Future<DateTime> getTime() async {
    final database = await connection();
    final raw = await database.query(tableTime);
    return DateTime.fromMillisecondsSinceEpoch(raw[0]["time"]);
  }

  Future<int> _getRawTime() async {
    final database = await connection();
    final raw = await database.query(tableTime);
    return raw[0]["time"];
  }

  @override
  Future<int> updateTime() async {
    // !todo BAD shoud just update instead of deleting and inserting new value
    final time = DateTime.now().millisecondsSinceEpoch;
    final database = await connection();
    final prevTime = await _getRawTime();
    await database.delete(tableTime);
    await database.insert(tableTime, {"time": time});
    return prevTime;
  }
}
