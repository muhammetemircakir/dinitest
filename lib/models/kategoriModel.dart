class Kategori {
  late int anaMenuId;
  late int kategoriId;
  late int dogru;
  late int yanlis;
  late int bos;
  late int acikMi;

  Kategori(this.anaMenuId,this.kategoriId,this.dogru,this.yanlis,this.bos,this.acikMi);

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['anaMenuId'] = anaMenuId;
    map['kategoriId'] = kategoriId;
    map['dogru'] = dogru;
    map['yanlis'] = yanlis;
    map['bos'] = bos;
    map['acikMi'] = acikMi;

    return map;
  }

  Kategori.fromMap(Map<dynamic, dynamic> map){
    this.anaMenuId = map['anaMenuId'];
    this.kategoriId = map['kategoriId'];
    this.dogru = map['dogru'];
    this.yanlis = map['yanlis'];
    this.bos = map['bos'];
    this.acikMi = map['acikMi'];
  }

}