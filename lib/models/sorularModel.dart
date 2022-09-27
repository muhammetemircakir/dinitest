class Sorular {
  late int anaMenuId;
  late int kategoriId;
  late String soru;
  late String a;
  late String b;
  late String c;
  late String d;
  late String cevap;
  Sorular(this.anaMenuId,this.kategoriId, this.soru, this.a, this.b,this.c,this.d,this.cevap);
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['anaMenuId'] = anaMenuId;
    map['kategoriId'] = kategoriId;
    map['soru'] = soru;
    map['a'] = a;
    map['b'] = b;
    map['c'] = c;
    map['d'] = d;
    map['cevap'] = cevap;
    return map;
  }

  Sorular.fromMap(Map<dynamic, dynamic> map){
    this.anaMenuId = map['anaMenuId'];
    this.kategoriId = map['kategoriId'];
    this.soru = map['soru'];
    this.a = map['a'];
    this.b = map['b'];
    this.c = map['c'];
    this.d = map['d'];
    this.cevap = map['cevap'];
  }

}