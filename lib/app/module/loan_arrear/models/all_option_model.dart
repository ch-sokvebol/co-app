import 'options_model.dart';

class AllOptionArrModel {
  List<OptionDetail>? solvingStatus;
  List<OptionDetail>? clientCommitment;
  List<OptionDetail>? status;
  List<OptionDetail>? reasonsOfOverdue;
  List<OptionDetail>? type;

  AllOptionArrModel(
      {this.solvingStatus,
      this.clientCommitment,
      this.status,
      this.reasonsOfOverdue,
      this.type});

  AllOptionArrModel.fromJson(Map<String, dynamic> json) {
    if (json['Solving status'] != null) {
      solvingStatus = <OptionDetail>[];
      json['Solving status'].forEach((v) {
        solvingStatus!.add(new OptionDetail.fromJson(v));
      });
    }
    if (json['Client commitment'] != null) {
      clientCommitment = <OptionDetail>[];
      json['Client commitment'].forEach((v) {
        clientCommitment!.add(new OptionDetail.fromJson(v));
      });
    }
    if (json['Status'] != null) {
      status = <OptionDetail>[];
      json['Status'].forEach((v) {
        status!.add(new OptionDetail.fromJson(v));
      });
    }
    if (json['Reasons of overdue'] != null) {
      reasonsOfOverdue = <OptionDetail>[];
      json['Reasons of overdue'].forEach((v) {
        reasonsOfOverdue!.add(new OptionDetail.fromJson(v));
      });
    }
    if (json['Type'] != null) {
      type = <OptionDetail>[];
      json['Type'].forEach((v) {
        type!.add(new OptionDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.solvingStatus != null) {
      data['Solving status'] =
          this.solvingStatus!.map((v) => v.toJson()).toList();
    }
    if (this.clientCommitment != null) {
      data['Client commitment'] =
          this.clientCommitment!.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['Status'] = this.status!.map((v) => v.toJson()).toList();
    }
    if (this.reasonsOfOverdue != null) {
      data['Reasons of overdue'] =
          this.reasonsOfOverdue!.map((v) => v.toJson()).toList();
    }
    if (this.type != null) {
      data['Type'] = this.type!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
