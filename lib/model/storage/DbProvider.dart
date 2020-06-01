import 'package:counter/model/HistoryModel.dart';
import 'package:counter/model/datetime.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const tableCounters = "Counters";
const tableTime = "Time";
const tableHistory = "History";
const _databaseName = "counters.db";

class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    final documentDir = await getDatabasesPath();
    final path = join(documentDir, _databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
        await _initCounters(db);
        await _initHistory(db);
      },
    );
  }

  _createTables(Database db) async {
    await db.execute("CREATE TABLE $tableHistory ("
        " id INTEGER PRIMARY KEY,"
        " $colCounterId INTEGER,"
        " $colDate INTEGER,"
        " $colValue INTEGER"
        ")");

    await db.execute("CREATE TABLE $tableTime ("
        " id INTEGER PRIMARY KEY,"
        " time INTEGER"
        ")");

    await db.execute("CREATE TABLE $tableCounters ("
        "id INTEGER PRIMARY KEY,"
        " title TEXT,"
        " value INTEGER,"
        " goal INTEGER,"
        " step INTEGER,"
        " unit TEXT,"
        " color_index INTEGER"
        ")");
  }

  _initCounters(Database db) async {
    await db.insert(tableCounters, {
      "title": "Pet the puppy",
      "value": "0",
      "goal": "30",
      "step": "3",
      "unit": "times",
      "color_index": "0",
    });
    await db.insert(tableCounters, {
      "title": "Pet the kitty",
      "value": "0",
      "goal": "30",
      "step": "3",
      "unit": "times",
      "color_index": "1",
    });
    await db.insert(tableCounters, {
      "title": "Play with parrot",
      "value": "0",
      "goal": "3",
      "step": "1",
      "unit": "times",
      "color_index": "2",
    });
    await db.insert(tableCounters, {
      "title": "Add new counter",
      "value": "0",
      "goal": "3",
      "step": "1",
      "unit": "unit",
      "color_index": "3",
    });
  }

  _initHistory(Database db) async {
    await db.insert(tableTime, {"time": DateTime.now().millisecondsSinceEpoch});

    final date = datetime();
    await db.insert(tableHistory, {
      "counter_id": 1,
      "value": 0,
      "date": date,
    });
    await db.insert(tableHistory, {
      "counter_id": 2,
      "value": 0,
      "date": date,
    });
    await db.insert(tableHistory, {
      "counter_id": 3,
      "value": 0,
      "date": date,
    });
    await db.insert(tableHistory, {
      "counter_id": 4,
      "value": 0,
      "date": date,
    });
  }
}
