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
  Future<bool> resetAll() async {
    final database = await connection();
    final result = await database.update(
      tableCounters,
      {"value": 0},
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
  Future<bool> clearHistoryFor(int id) async {
    final database = await connection();
    final deleted = await database.delete(
      tableHistory,
      where: "$colCounterId = ?",
      whereArgs: [id],
    );
    return deleted > 0;
  }

  @override
  Future<bool> insertHistory(int id, int value, int timestamp) async {
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
  Future<bool> updateTodayHistory(int id, int value) async {
    final database = await connection();
    final dt = datetime();
    final result = await database.update(
      tableHistory,
      {
        colCounterId: id,
        colValue: value,
      },
      where: "$colCounterId = ? and $colDate = ?",
      whereArgs: [id, dt],
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
    final time = datetime();
    final database = await connection();
    final prevTime = await _getRawTime();
    await database.update(tableTime, {"time": time}, where: "id=?", whereArgs: [1]);
    return prevTime;
  }
}
