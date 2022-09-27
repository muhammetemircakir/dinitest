 import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



class DataBaseVeriEkleme {
  static DataBaseVeriEkleme? _databaseHelper;
  static Database ?_datebase;

  String _WordTablo = "WordInfo";
  String _WordId = "WordID";
  String _Isim = "Isim";
  String _Tur = "Tur";
  String _Tanim = "Tanim";
  String _Cumle = "Cumle";
  String _WordSynonTablo = "WordSynon";
  String _WordId2 = "WordID";
  String _Isim2 = "synonyms";
  String _PuanTablo = "PuanTablo";
  String _AnamenuID = "AnamenuID";
  String _CategoriID = "CategoriID";
  String _Puan = "Puan";
  String _Acikmi = "Acikmi";

  factory DataBaseVeriEkleme() {
    if (_databaseHelper == null) {
      _databaseHelper = DataBaseVeriEkleme._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }

  DataBaseVeriEkleme._internal();

  Future<Database> _getDatabase() async {
    if (_datebase == null) {
      _datebase = await _initializeDatabase();
      return _datebase!;

    } else {
      return _datebase!;
    }
  }

  _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbPath = join(klasor.path, "Words.db");

    var kullaniciDB = openDatabase(dbPath, version: 1, onCreate: _createDB);
    return kullaniciDB;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute("CREATE TABLE $_WordTablo ($_WordId TEXT, $_Isim TEXT, $_Tur TEXT, $_Tanim TEXT, $_Cumle TEXT )");
    await db.execute("CREATE TABLE $_WordSynonTablo ($_WordId2 TEXT, $_Isim2 TEXT )");
    await db.execute("CREATE TABLE $_PuanTablo ($_AnamenuID TEXT, $_CategoriID TEXT, $_Puan TEXT, $_Acikmi TEXT )");

  }


  Future<int> sozEkle(DbWordInfo sozler) async{
    var db =await _getDatabase();

    var sonuc=await db.insert(_WordTablo,sozler.toMap(),);
    return sonuc;
  }

  Future<int> synonEkle(DbWordSynonyms sozler1) async{
    var db =await _getDatabase();

    var sonuc=await db.insert(_WordSynonTablo,sozler1.toMap(),);
    return sonuc;
  }

  Future<List<DbWordInfo>> tumBilgileriGetir()async{
    var db= await _getDatabase();
    var sonuc= await db.query(_WordTablo);
    var skorListesi = List<DbWordInfo>.empty(growable: true);
    for(Map map in sonuc){
      skorListesi.add(DbWordInfo.fromMap(map));
    }
    return skorListesi;
  }

  Future<List<DbWordSynonyms>> tumSynonsGetir()async{
    var db= await _getDatabase();
    var sonuc= await db.query(_WordSynonTablo);
    var skorListesi = List<DbWordSynonyms>.empty(growable: true);
    for(Map map in sonuc){
      skorListesi.add(DbWordSynonyms.fromMap(map));
    }
    return skorListesi;
  }

  Future<bool>  favorikontrol(String WordID) async{
    var db= await _getDatabase();
    var sonuc = await db.query(_WordTablo, where: '$_WordId = ? ', whereArgs: [WordID]);

    var kategoriListesi = List<DbWordInfo>.empty(growable: true);

    for(Map map in sonuc){
      kategoriListesi.add(DbWordInfo.fromMap(map));
    }

    return kategoriListesi.isEmpty?false:true;
  }
  
  Future<List<DbWordSynonyms>>  synonGetir(String WordID) async{
    var db= await _getDatabase();
    var sonuc = await db.query(_WordSynonTablo, where: '$_WordId = ? ', whereArgs: [WordID]);

    var kategoriListesi = List<DbWordSynonyms>.empty(growable: true);

    for(Map map in sonuc){
      kategoriListesi.add(DbWordSynonyms.fromMap(map));
    }

    return kategoriListesi;
  }

  Future<int> sozSil(String WordID) async{
    var db=await _getDatabase();
    var sonuc = await db.delete(_WordTablo, where: '$_WordId = ? ', whereArgs: [WordID]);
    var sonuc1 = await db.delete(_WordSynonTablo, where: '$_WordId = ? ', whereArgs: [WordID]);
    return sonuc;
  }



}


