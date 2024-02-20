import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../../providers/manageService.dart';
import '../../../../utils/storages/const.dart';
import '../../loan_arrear/models/user_model.dart';

class SearchCOController extends GetxController {
  final isLoading = false.obs;
  final searchComodel = FilterUserModel().obs;
  var searchCoList = <FilterUserModel>[].obs;
  var userName = ''.obs;
  var userID = 0.obs;
  var isSelect = false.obs;
  Future<void> searchAllCO(String? searchusername) async {
    isLoading(true);
    final typeUser = await storage.read(key: 'user_type');
    final branCode = await storage.read(key: 'branch');
    try {
      var body = json.encode({
        "pageSize": 20,
        "pageNumber": 1,
        "searchusername": "$searchusername",
        "bcode": typeUser == 'BM' ? '$branCode' : null
      });
      debugPrint("body : $body");
      await http
          .post(Uri.parse(baseURLInternal + 'Users/search'),
              headers: {'Content-Type': 'application/json'}, body: body)
          .then((res) {
        var resJson = json.decode(res.body);
        searchCoList.value = [];
        resJson.map((e) {
          searchComodel.value = FilterUserModel.fromJson(e);
          searchCoList.add(searchComodel.value);
        }).toList();
        refresh();
      });
    } catch (Error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
