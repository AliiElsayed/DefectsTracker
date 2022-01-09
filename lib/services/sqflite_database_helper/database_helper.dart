import 'package:defects_tracker/models/item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants.dart';

class DatabaseHelper {
  DatabaseHelper();
  List<ItemModel> allItems = [];
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'chairs.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        print('database created.......');
        await database.execute(''' CREATE TABLE $tableName( 
             $itemId INTEGER PRIMARY KEY ,
             $itemTitle TEXT NOT NULL,
             $itemDescription TEXT NOT NULL, 
             $itemImage TEXT NOT NULL, 
             $itemStatus TEXT NOT NULL , 
             $pickedDateTime INTEGER NOT NULL )''');
        print('table created.......');
      },
    );
  }

  Future<List<ItemModel>> getAllItems() async {
    var clientDb = await database;
    List<Map> itemsList = await clientDb.query(tableName);
    List<ItemModel> allStoredItems = itemsList.isNotEmpty
        ? itemsList.map((item) => ItemModel.fromJson(item)).toList()
        : [];
    return allStoredItems;
  }

  Future<int> insert(context, ItemModel model) async {
    try {
      var clientDb = await database;
      return await clientDb.insert(
        tableName,
        model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } on DatabaseException {
      return 0;
    }
  }

  update(ItemModel model) async {
    var clientDB = await database;
    await clientDB.update(tableName, model.toJson(),
        where: ' $itemId = ?', whereArgs: ['${model.id}']);
  }

  deleteItem(int id) async {
    var clientDB = await database;
    await clientDB.delete('$tableName', where: '$itemId = ?', whereArgs: [id]);
  }
}
