import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class DatabaseHelper {

  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: (db, version) {
      db.execute(
          '''
          CREATE TABLE playlist(
          playlist_name TEXT PRIMARY KEY)
          '''
      );
      db.execute(
          '''
          CREATE TABLE song(
          song_name TEXT,
          playlist_name TEXT,
          artist TEXT,
          album TEXT,
          url TEXT,
          image TEXT,
          PRIMARY KEY (song_name, playlist_name))
          '''
      );
    });
  }

  Future<int> insertPlaylist(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('playlist', row);
  }

  Future<List<Map<String, dynamic>>> getAllPlaylist() async {
    Database db = await instance.database;
    return await db.query('playlist');
  }

  Future<int> deletePlaylist(String name) async {
    Database db = await instance.database;
    return await db.delete('playlist', where: 'playlist_name = ?', whereArgs: [name]);
  }

  Future<int> insertSong(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('song', row);
  }

  Future<List<Map<String, dynamic>>> findSongs(String playlistName) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM song WHERE playlist_name = \'$playlistName\'');
  }

  Future<int> deleteSong(String song_name, String playlist_name) async {
    Database db = await instance.database;
    return await db.delete('song', where: 'song_name = ? AND playlist_name = ?', whereArgs: [song_name, playlist_name]);
  }

  Future<int> deleteAllSongs(String playlist_name) async {
    Database db = await instance.database;
    return await db.delete('song', where: 'playlist_name = ?', whereArgs: [playlist_name]);
  }
  //{
    //"_id": 12
    //"name": "Sang"
  //}

  /*Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(_tableName, row, where: '$columnId = ?', whereArgs: [row[columnId]]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }*/
}