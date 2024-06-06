import 'package:sqflite/sqflite.dart';
import '../models/contact_model.dart';

class LocalDatabase {
  LocalDatabase._singleton();

  static final LocalDatabase _localDatabase = LocalDatabase._singleton();

  factory LocalDatabase() {
    return _localDatabase;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    print(_database);
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$getDatabasesPath/contacts.db';
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
  CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    phone TEXT NOT NULL,
    image TEXT,
  )
  ''');
  }

  Future<void> addContact(Contact contact) async {
    await _database!.insert("contacts", {
      'name': contact.name,
      'phone': contact.phone,
      'image': contact.image,
    });
  }
}

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../models/contact_model.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._instance();
//   static Database? _database;
//
//   DatabaseHelper._instance();
//
//   String contactTable = 'contact_table';
//   String colId = 'id';
//   String colName = 'name';
//   String colPhone = 'phone';
//   String colImagePath = 'imagePath';
//
//   Future<Database?> get db async {
//     _database ??= await _initDb();
//     return _database;
//   }
//
//   Future<Database> _initDb() async {
//     final dir = await getDatabasesPath();
//     final path = join(dir, 'contact_list.db');
//     final contactListDb = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDb,
//     );
//     return contactListDb;
//   }
//
//   void _createDb(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE $contactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colPhone TEXT, $colImagePath TEXT)',
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> getContactMapList() async {
//     Database? db = await this.db;
//     final List<Map<String, dynamic>> result = await db!.query(contactTable);
//     return result;
//   }
//
//   Future<int> insertContact(Contact contact) async {
//     Database? db = await this.db;
//     final int result = await db!.insert(contactTable, contact.toMap());
//     return result;
//   }
//
//   Future<int> updateContact(Contact contact) async {
//     Database? db = await this.db;
//     final int result = await db!.update(
//       contactTable,
//       contact.toMap(),
//       where: '$colId = ?',
//       whereArgs: [contact.id],
//     );
//     return result;
//   }
//
//   Future<int> deleteContact(int id) async {
//     Database? db = await this.db;
//     final int result = await db!.delete(
//       contactTable,
//       where: '$colId = ?',
//       whereArgs: [id],
//     );
//     return result;
//   }
// }
