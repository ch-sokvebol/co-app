class SQLItem {
  int? id;
  String? name;
  int? age;

  SQLItem({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["age"] = age;
    return map;
  }

  SQLItem.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    age = map["age"];
  }
}
