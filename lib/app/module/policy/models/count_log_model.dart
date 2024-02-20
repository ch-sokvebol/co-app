class CountLogModel {
  String? description;
  int? count;

  CountLogModel({this.description, this.count});

  CountLogModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['count'] = this.count;
    return data;
  }
}
