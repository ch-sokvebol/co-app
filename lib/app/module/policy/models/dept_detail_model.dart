class DeptDetailModel {
  int? id;
  String? title;
  String? type;
  String? releasedate;
  String? createdate;
  int? departmentid;
  String? url;
  int? status;
  int? isTop;

  DeptDetailModel({
    this.id,
    this.title,
    this.type,
    this.releasedate,
    this.createdate,
    this.departmentid,
    this.url,
    this.status,
    this.isTop,
  });

  DeptDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    releasedate = json['releasedate'];
    createdate = json['createdate'];
    departmentid = json['departmentid'];
    url = json['url'];
    status = json['status'];
    isTop = json['isTop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['releasedate'] = this.releasedate;
    data['createdate'] = this.createdate;
    data['departmentid'] = this.departmentid;
    data['url'] = this.url;
    data['status'] = this.status;
    data['isTop'] = this.isTop;
    return data;
  }
}
