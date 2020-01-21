import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const tableCounters = "Counters";
const tableTime = "Time";
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
        await db.execute("CREATE TABLE $tableTime ("
            " id INTEGER PRIMARY KEY,"
            " time INTEGER)");

        final dt = DateTime.now().subtract(Duration(days: 1));
        await db.insert(tableTime, {"time": dt.millisecondsSinceEpoch});

        await db.execute("CREATE TABLE $tableCounters ("
            "id INTEGER PRIMARY KEY,"
            " title TEXT,"
            " value INTEGER,"
            " goal INTEGER,"
            " step INTEGER,"
            " unit TEXT,"
            " color_index INTEGER)");
        await db.insert(tableCounters, {
          "title": "Aquadetrim",
          "value": "2000",
          "goal": "4000",
          "step": "500",
          "unit": "ME",
          "color_index": "0",
        });
        await db.insert(tableCounters, {
          "title": "Приседания",
          "value": "30",
          "goal": "100",
          "step": "15",
          "unit": "times",
          "color_index": "1",
        });
        await db.insert(tableCounters, {
          "title": "Отжимания",
          "value": "20",
          "goal": "50",
          "step": "10",
          "unit": "times",
          "color_index": "2",
        });
      },
    );
  }
}
