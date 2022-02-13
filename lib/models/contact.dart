class Contact{

  static const nameKey = 'name';
  static const numberKey = 'number';
  static const idKey = 'id';


  Contact({this.id,this.name,this.number});


  int? id;
  String? name;
  String? number;

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{nameKey:name,numberKey:number};
    if(id!=null) map[idKey]=id;
    return map;
  }

  Contact.fromMap(Map<String,dynamic> map){
    id = map[idKey];
    name=map[nameKey];
    number = map[numberKey];
  }
}