class AnaMenu{
  late int id;
  late String name;
  late String image;

  AnaMenu(this.id, this.name, this.image);

  Map<dynamic, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

  AnaMenu.fromMap(Map<dynamic, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.image = map['image'];
  }
}