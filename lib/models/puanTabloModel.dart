class PuanTablo {
  late String? anaMenuId;
  late String? kategoriId;
  late String? soruId;
  late String? cevap;
  PuanTablo(this.anaMenuId, this.kategoriId, this.soruId, this.cevap);

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['anaMenuId'] = anaMenuId;
    map['kategoriId'] = kategoriId;
    map['soruId'] = soruId;
    map['cevap'] = cevap;
    return map;
  }

  PuanTablo.fromMap(Map<dynamic, dynamic> map){
    this.anaMenuId = map['anaMenuId'];
    this.kategoriId   = map['kategoriId'];
    this.soruId   = map['soruId'];
    this.cevap  = map['cevap'];
  }

}