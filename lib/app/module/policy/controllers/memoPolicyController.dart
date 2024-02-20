import 'dart:convert';

import 'package:chokchey_finance/app/module/policy/models/count_log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../models/dept_detail_model.dart';
import '../models/memo_policy_model.dart';
import 'package:http/http.dart' as http;

class MemoPolicyController extends GetxController {
  final memoPolicyModel = MemoPolicyModel().obs;
  final memoPolicyList = <MemoPolicyModel>[].obs;
  final isLoadingPolicy = false.obs;
  var resDetail;
  Future<MemoPolicyModel> getMemoPolicy() async {
    isLoadingPolicy(true);
    String url = dotenv.get('baseURL');
    // https://localhost:5001/api/MemoPolicy/dept
    try {
      await http.get(
          Uri.parse('$url' + 'MemoPolicy/department'
              // 'http://45.115.209.191:2020/api/MemoPolicy/department'
              ),
          // Uri.parse('addresses/provinces')
          headers: {
            "Content-Type": "Application/json",
            // "Accept": "Application/json"
          }).then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body)['dept'];
          memoPolicyList.clear();
          resJson.map((e) {
            memoPolicyModel.value = MemoPolicyModel.fromJson(e);
            memoPolicyList.add(memoPolicyModel.value);
          }).toList();
        } else {
          debugPrint('errrrrr=====:${res.statusCode}');
        }
      });
    } catch (e) {
      isLoadingPolicy(false);
    } finally {
      isLoadingPolicy(false);
    }

    return memoPolicyModel.value;
  }

  final isLoadingDeptDetail = false.obs;
  final deptDetailModel = DeptDetailModel().obs;
  final deptDetailList = <DeptDetailModel>[].obs;
  Future<List<DeptDetailModel>> getMemoPolicyDetail({int? id}) async {
    isLoadingDeptDetail(true);
    String url = dotenv.get('baseURL');
    try {
      await http.get(Uri.parse('$url' + 'MemoPolicy/detail/$id'),
          // Uri.parse('addresses/provinces')
          headers: {
            "Content-Type": "Application/json",
            // "Accept": "Application/json"
          }).then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          deptDetailList.clear();
          resJson.map((e) {
            deptDetailModel.value = DeptDetailModel.fromJson(e);
            deptDetailList.add(deptDetailModel.value);
          }).toList();
        } else {
          debugPrint('errrrrr=====:${res.statusCode}');
        }
      });
    } catch (e) {
      isLoadingDeptDetail(false);
    } finally {
      isLoadingDeptDetail(false);
    }

    return deptDetailList;
  }

  final isLoadingTop = false.obs;
  final topModel = DeptDetailModel().obs;
  final toplList = <DeptDetailModel>[].obs;
  Future<List<DeptDetailModel>> getTopDepartment() async {
    isLoadingTop(true);
    String url = dotenv.get('baseURL');
    // String url = 'https://localhost:5001/api/';
    try {
      await http.get(Uri.parse('$url' + 'MemoPolicy/top'), headers: {
        "Content-Type": "Application/json",
        // "Accept": "Application/json"
      }).then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          toplList.clear();
          resJson.map((e) {
            topModel.value = DeptDetailModel.fromJson(e);
            toplList.add(topModel.value);
          }).toList();
        } else {}
      });
    } catch (e) {
      isLoadingTop(false);
    } finally {
      isLoadingTop(false);
    }

    return toplList;
  }

  final countLogModel = CountLogModel().obs;
  final countLogList = <CountLogModel>[].obs;
  final isLoadingGetActLog = false.obs;
  Future<List<CountLogModel>> getActLog() async {
    isLoadingGetActLog.value = true;
    String url = dotenv.get('baseURL');
    // final url = 'https://localhost:5001/api/ActivityLog/get_log';
    final header = {"Content-Type": "Application/json"};
    final res =
        await http.get(Uri.parse(url + 'ActivityLog/get_log'), headers: header);
    try {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        countLogList.clear();
        resJson.map((e) {
          countLogModel.value = CountLogModel.fromJson(e);
          countLogList.add(countLogModel.value);
        }).toList();
      }
    } catch (e) {
    } finally {
      isLoadingGetActLog.value = false;
    }
    return countLogList;
  }

  final memoPolicyModelDetail = DepartmentDetails().obs;
  final memoPolicyListDetail = <DepartmentDetails>[].obs;
  final isLoadingPolicyDetail = false.obs;
  // Future<List<DepartmentDetails>> getMemoPolicyDetail(int? id) async {
  //   isLoadingPolicyDetail(true);
  //   debugPrint('first=====:');
  //   try {
  //     await http.get(Uri.parse('https://localhost:5001/api/MemoPolicy/dept'),
  //         // Uri.parse('addresses/provinces')
  //         headers: {
  //           "Content-Type": "Application/json",
  //           // "Accept": "Application/json"
  //         }).then((res) {
  //       if (res.statusCode == 200) {
  //         debugPrint('okkk=====:${res.body}');
  //         // var resJson = json.decode(res.body);
  //         var detail = json.decode(res.body)['departmentDetails'];
  //         // resDetail = detail;

  //         // var detail = resJson['departmentDetails'];
  //         // resDetail = detail;
  //         debugPrint('lllllll:$detail');
  //         memoPolicyListDetail.clear();
  //         detail.map((e) {
  //           memoPolicyModelDetail.value = DepartmentDetails.fromJson(e);
  //           memoPolicyListDetail.add(memoPolicyModelDetail.value);
  //           debugPrint('okkk=====1111:${res.body}');
  //         }).toList();
  //       } else {
  //         debugPrint('errrrrroorr=====:${res.body}');
  //         debugPrint('errrrrr=====:${res.statusCode}');
  //       }
  //     });
  //   } catch (e) {
  //     isLoadingPolicyDetail(false);
  //     debugPrint('catch=====>>>>>>>:${e.toString()}');
  //   } finally {
  //     isLoadingPolicyDetail(false);
  //   }

  //   return memoPolicyListDetail;
  // }
  @override
  void onInit() {
    getActLog();
    super.onInit();
  }
}
