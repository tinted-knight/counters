import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const tableCounters = "Counters";
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
        await db.execute("CREATE TABLE $tableCounters ("
            "id INTEGER PRIMARY KEY,"
            " title TEXT, "
            "value INTEGER, "
            "goal INTEGER,"
            " unit TEXT, "
            "color_index INTEGER)");
      },
    );
  }
}
