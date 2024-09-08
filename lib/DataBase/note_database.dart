import 'package:path/path.dart';
import 'package:simple_notes_app/DataBase/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NoteDataBase {
  static final NoteDataBase _instance = NoteDataBase._internal();
  NoteDataBase._internal();
  static const int version = 1;
  Database? _db;
  factory NoteDataBase() {
    return _instance;
  }
  Future<Database> get dataBase async {
    if (_db != null) {
      return _db!;
    }
    _db = await intiallizeDataBase();
    return _db!;
  }

  Future<Database> intiallizeDataBase() async {
    var path = await join(await getDatabasesPath(), "notes.db");
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) {
        return db.execute(NoteModel.createTable);
      },
    );
  }

  Future<bool> insertNotes(NoteModel noteModel) async {
    var db = await dataBase;
    int rowId = await db.insert(NoteModel.tableName, noteModel.toMap());
    return rowId > 0;
  }

  Future<bool> updateNotes(NoteModel noteModel) async {
    var db = await dataBase;
    int rowId = await db.update(NoteModel.tableName, noteModel.toMap(),
        where: "${NoteModel.colId}=?", whereArgs: [noteModel.id]);
    return rowId > 0;
  }

  Future<bool> deleteNotes(NoteModel noteModel) async {
    var db = await dataBase;
    int rowId = await db.delete(NoteModel.tableName,
        where: "${NoteModel.colId}=?", whereArgs: [noteModel.id]);
    return rowId > 0;
  }

  Future<List<NoteModel>> fetchNotes() async {
    var db = await dataBase;
    const orderBy = '${NoteModel.colDateTime} DESC';
    List<Map<String, dynamic>> mapOfNotes =
        await db.query(NoteModel.tableName, orderBy: orderBy);
    return mapOfNotes.map((map) => NoteModel.fromMap(map)).toList();
  }

  Future<List<NoteModel>> fetchNote(int id) async {
    var db = await dataBase;
    var record = await db
        .rawQuery("SELECT * FROM ${NoteModel.tableName} WHERE id = ?", [id]);
    if (record.isNotEmpty) {
      return record.map((singleMap) => NoteModel.fromMap(singleMap)).toList();
    } else {
      throw Exception("User: $id not found");
    }
  }

  Future<List<NoteModel>> fetchNoteByTitle(String title) async {
    var db = await dataBase;
    var record = await db.rawQuery(
        "SELECT * FROM ${NoteModel.tableName} WHERE title = ?", [title]);
    if (record.isNotEmpty) {
      return record.map((singleMap) => NoteModel.fromMap(singleMap)).toList();
    } else {
      throw Exception("User: $title not found");
    }
  }

  Future close() async {
    final db = await dataBase;
    db.close();
  }
}
