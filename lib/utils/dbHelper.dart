import 'dart:io';
import 'dart:math';
import 'package:dinisorular/models/anaMenuModel.dart';
import 'package:dinisorular/models/kategoriModel.dart';
import 'package:dinisorular/models/sorularModel.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';


class DatabaseHelper{

  static DatabaseHelper ?_databaseHelper;
  static Database ?_database;

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    }else{
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async{
    if(_database == null){
      _database = await _initializeDatabase();
      return _database!;
    }else{
      return _database!;
    }
  }

  Future<Database> _initializeDatabase() async {

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "dinisorular.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/data", "dinisorular.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
// open the database
    return await openDatabase(path, readOnly: false);

  }

  Future<List<Map<String,dynamic>>> anaMenuGet() async{
    var db= await _getDatabase();
    var sonuc = await db.query("anamenu");
    return sonuc;
  }

  Future<List<AnaMenu>> kategoriListesiniGetir() async{

    var kategorileriIcerenMapListesi = await anaMenuGet();
    List<AnaMenu>? kategoriListesi = List.empty(growable: true);
    for(Map map in kategorileriIcerenMapListesi){
      kategoriListesi.add(AnaMenu.fromMap(map));
    }
    return kategoriListesi;

  }

  Future<List<Map<String,dynamic>>> kategorileriGetir(int id) async{
    var db= await _getDatabase();
    var sonuc = await db.rawQuery('select * from "kategori" where anaMenuId=$id');
    return sonuc;
  }


  Future<List<Kategori>> kategoriGet(int id) async{

    var CategoriesDetailsleriIcerenMapListesi = await kategorileriGetir(id);
    List<Kategori>? CategoriesDetailsListesi = List.empty(growable: true);
    for(Map map in CategoriesDetailsleriIcerenMapListesi){
      CategoriesDetailsListesi.add(Kategori.fromMap(map));

    }
    return CategoriesDetailsListesi;
  }


  Future<List<Map<String,dynamic>>> soruGet(int id,int kId) async{
    var db= await _getDatabase();
    var sonuc = await db.rawQuery('select * from "sorular" where anaMenuId=$id AND kategoriId=$kId');
    return sonuc;
  }

  Future<List<Sorular>> sorularGet(int id,int kId) async{
    var CategoriesDetailsleriIcerenMapListesi = await soruGet(id,kId);
    List<Sorular> CategoriesDetailsListe = List.empty(growable: true);
    for(Map map in CategoriesDetailsleriIcerenMapListesi){
      CategoriesDetailsListe.add(Sorular.fromMap(map));
    }
    return CategoriesDetailsListe;
  }

  Future<int> kategoriGuncelle(Kategori data,int AnaMenuID,int KategoriID) async{
    var db=await _getDatabase();

    var result = await db.update("kategori", data.toMap(), where: 'anaMenuId = ? AND kategoriId = ? ', whereArgs: [AnaMenuID,KategoriID]);

    return result;
  }




}