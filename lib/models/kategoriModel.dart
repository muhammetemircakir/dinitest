class Kategori {
  late int anaMenuId;
  late int kategoriId;
  
  Kategori(this.anaMenuId,this.kategoriId);
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['anaMenuId'] = anaMenuId;
    map['kategoriId'] = kategoriId;

    return map;
  }

  Kategori.fromMap(Map<dynamic, dynamic> map){
    this.anaMenuId = map['anaMenuId'];
    this.kategoriId = map['kategoriId'];
  }

}