class OptionDetail {
  int? id;
  int? optionId;
  String? display;

  OptionDetail({
    this.id,
    this.optionId,
    this.display,
  });

  OptionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionId = json['option_id'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['option_id'] = this.optionId;
    data['display'] = this.display;
    return data;
  }
}
