class DogruYanlisTablo {
  late String? anaMenuId;
  late String? kategoriId;
  late String? dogru;
  late String? yanlis;
  late String? bos;
  DogruYanlisTablo(this.anaMenuId, this.kategoriId, this.dogru, this.yanlis,this.bos);

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['anaMenuId'] = anaMenuId;
    map['kategoriId'] = kategoriId;
    map['dogru'] = dogru;
    map['yanlis'] = yanlis;
    map['bos'] = bos;
    return map;
  }

  DogruYanlisTablo.fromMap(Map<dynamic, dynamic> map){
    this.anaMenuId = map['anaMenuId'];
    this.kategoriId   = map['kategoriId'];
    this.dogru   = map['dogru'];
    this.yanlis  = map['yanlis'];
    this.bos  = map['bos'];
  }

}