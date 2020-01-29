import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'DbProvider.dart';
import 'interface.dart';

class SQLiteStorageProvider implements ILocalStorage<CounterItem> {
  Future<Database> connection() async {
    return DbProvider.db.database;
  }

  @override
  Future<bool> add(CounterItem item) async {
    final database = await connection();
    return await database.insert(tableCounters, item.toMap()) >= 0;
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
  Future<bool> updateHistory(CounterItem item, String timestamp) async {
    final value = {
      colCounterId: item.id.toString(),
      colDate: timestamp,
      colValue: item.value.toString(),
    };
    final database = await connection();
    final result = await database.insert(tableHistory, value);
    return result > 0;
  }

  @override
  Future<DateTime> getTime() async {
    final database = await connection();
    final raw = await database.query(tableTime);
    return DateTime.fromMillisecondsSinceEpoch(raw[0]["time"]);
  }

  @override
  Future<bool> updateTime(int time) async {
    final database = await connection();
    await database.delete(tableTime);
    final updated = await database.insert(tableTime, {"time": time});
    return updated > 0;
  }
}
