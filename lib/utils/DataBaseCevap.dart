 import 'dart:async';
import 'dart:io';
import 'package:dinisorular/models/dogruYanlisTablodModel.dart';
import 'package:dinisorular/models/puanTabloModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



class DataBaseCevap {
  static DataBaseCevap? _databaseHelper;
  static Database ?_datebase;

  String _dogruYanlisTablo = "dogruYanlisTablo";
  String _dogru = "dogru";
  String _yanlis = "yanlis";
  String _bos = "bos";
  String _PuanTablo = "PuanTablo";
  String _anaMenuId = "anaMenuId";
  String _kategoriId = "kategoriId";
  String _soruId = "soruId";
  String _cevap = "cevap";

  factory DataBaseCevap() {
    if (_databaseHelper == null) {
      _databaseHelper = DataBaseCevap._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }

  DataBaseCevap._internal();

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

    await db.execute("CREATE TABLE $_PuanTablo ($_anaMenuId TEXT, $_kategoriId TEXT, $_soruId TEXT, $_cevap TEXT )");
    await db.execute("CREATE TABLE $_dogruYanlisTablo ($_anaMenuId TEXT, $_kategoriId TEXT, $_dogru TEXT, $_yanlis TEXT, $_bos TEXT )");

  }

  Future<int> dogruYanlisEkle(DogruYanlisTablo dogru) async{
    var db =await _getDatabase();

    var sonuc = await db.insert(_dogruYanlisTablo,dogru.toMap(),);


    return sonuc;
  }

  Future<bool>  dogruYanlis(DogruYanlisTablo dogru,String anamenuID,String kategoriID) async{
    var db= await _getDatabase();
    var sonuc = await db.query(_dogruYanlisTablo, where: '$_anaMenuId = ? AND $_kategoriId = ? ', whereArgs: [anamenuID,kategoriID]);

    var kategoriListesi = List<DogruYanlisTablo>.empty(growable: true);

    for(Map map in sonuc){
      kategoriListesi.add(DogruYanlisTablo.fromMap(map));
    }
    if(kategoriListesi.isEmpty)
      dogruYanlisEkle(dogru);
    else
      kategoriAcGuncelle(dogru,anamenuID, kategoriID);

    return kategoriListesi.isEmpty?false:true;
  }

  Future<int> kategoriAcGuncelle(DogruYanlisTablo data,String AnaMenuID,String KategoriID) async{
    var db=await _getDatabase();

    var result = await db.update("$_dogruYanlisTablo", data.toMap(), where: '$_anaMenuId = ? AND $_kategoriId = ? ', whereArgs: [AnaMenuID,KategoriID]);


    return result;
  }


  Future<DogruYanlisTablo> doruYanlisBilgsiniGetir(String anaMenuId,String kategoriId)async{
    var db= await _getDatabase();
    var sonuc = await db.query(_dogruYanlisTablo, where: '$_anaMenuId = ? AND $_kategoriId = ? ', whereArgs: [anaMenuId,kategoriId]);
    late DogruYanlisTablo skor;
    for(Map map in sonuc){
      skor = DogruYanlisTablo.fromMap(map);
    }
    return skor;
  }

  Future<int> cevapEkle(PuanTablo cevap) async{
    var db =await _getDatabase();

    var sonuc=await db.insert(_PuanTablo,cevap.toMap(),);

    return sonuc;
  }


  Future<List<PuanTablo>> tumBilgileriGetir()async{
    var db= await _getDatabase();
    var sonuc= await db.query(_PuanTablo);
    var skorListesi = List<PuanTablo>.empty(growable: true);
    for(Map map in sonuc){
      skorListesi.add(PuanTablo.fromMap(map));
    }
    return skorListesi;
  }

  Future<List<PuanTablo>> soruBilgsiniGetir(String soruId)async{
    var db= await _getDatabase();
    var sonuc = await db.query(_PuanTablo, where: '$_soruId = ? ', whereArgs: [soruId]);
    var skorListesi = List<PuanTablo>.empty(growable: true);
    for(Map map in sonuc){
      skorListesi.add(PuanTablo.fromMap(map));
    }
    return skorListesi;
  }

/*
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
*/
  Future<int> tumCevapSil(String anaMenuId,String kategoriId) async{
    var db=await _getDatabase();
    var sonuc = await db.delete(_PuanTablo, where: '$_anaMenuId = ? AND $_kategoriId = ? ', whereArgs: [anaMenuId,kategoriId]);
    var sonuc1 = await db.delete(_dogruYanlisTablo, where: '$_anaMenuId = ? AND $_kategoriId = ? ', whereArgs: [anaMenuId,kategoriId]);
    return sonuc;
  }

  Future<int> tumTestcevapSil(String soruId) async{
    var db=await _getDatabase();
    var sonuc = await db.delete(_PuanTablo, where: '$_anaMenuId = ? ', whereArgs: [soruId]);
    return sonuc;
  }



}


