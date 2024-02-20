class MemoPolicyModel {
  int? id;
  String? name;
  int? status;
  List<DepartmentDetails>? departmentDetails;

  MemoPolicyModel({this.id, this.name, this.status, this.departmentDetails});

  MemoPolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    if (json['departmentDetails'] != null) {
      departmentDetails = <DepartmentDetails>[];
      json['departmentDetails'].forEach((v) {
        departmentDetails!.add(new DepartmentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    if (this.departmentDetails != null) {
      data['departmentDetails'] =
          this.departmentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepartmentDetails {
  int? id;
  String? title;
  String? type;
  String? releasedate;
  String? createdate;
  int? departmentid;
  String? url;

  DepartmentDetails(
      {this.id,
      this.title,
      this.type,
      this.releasedate,
      this.createdate,
      this.departmentid,
      this.url});

  DepartmentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    releasedate = json['releasedate'];
    createdate = json['createdate'];
    departmentid = json['departmentid'];
    url = json['url'];
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
    return data;
  }
}
