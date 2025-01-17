import 'dart:convert';

import 'package:chokchey_finance/providers/manageService.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class ApprovalHistoryProvider {
  final storage = new FlutterSecureStorage();

  //Request list Approval History Summary
  Future getApprovalHistorySummary(
      _pageSize, _pageNumber, status, code, bcode, sdate, edate) async {
    try {
      var token = await storage.read(key: 'user_token');
      var user_ucode = await storage.read(key: "user_ucode");
      var branch = await storage.read(key: "branch");
      var level = await storage.read(key: "level");
      var sdates = sdate != null ? sdate : '';
      var edates = edate != null ? edate : '';
      var codes = code != null ? code : '';
      var statuses = status != null ? status : '';
      var btlcode = status != null ? status : '';
      var bcodes;
      var ucode;

      if (level == '3') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        btlcode = '';
        ucode = codes != null && codes != "" ? codes : "";
      }

      if (level == '2') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        btlcode = user_ucode;
        ucode = code != null && code != "" ? code : '';
      }

      if (level == '1') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        ucode = user_ucode;
        btlcode = '';
      }

      if (level == '4' || level == '5' || level == '6') {
        bcodes = bcode != null && bcode != "" ? bcode : '';
        btlcode = '';
        ucode = code != null && code != "" ? code : '';
      }

      // bodyRow =
      //     "{\n    \"pageSize\": $_pageSize,\n    \"pageNumber\": $_pageNumber,\n    \"ucode\": \"$ucode\",\n    \"bcode\": \"$bcodes\",\n    \"btlcode\": \"$btlcode\",\n    \"status\": \"\",\n    \"code\": \"\",\n    \"sdate\": \"$sdates\",\n    \"edate\": \"$edates\"\n}";

      final Map<String, dynamic> bodyRow = {
        "pageSize": "$_pageSize",
        "pageNumber": "$_pageNumber",
        "ucode": "$ucode",
        "bcode": "$bcodes",
        "btlcode": "$btlcode",
        "status": "$statuses",
        "code": "",
        "sdate": "$sdates",
        "edate": "$edates"
      };
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Response response = await api().post(
          Uri.parse(baseURLInternal + 'reports/summary'),
          headers: headers,
          body: json.encode(bodyRow));
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);
        return list;
      }
    } catch (error) {
      logger().e('error :: ${error}');
    }
  }

  //Request list Approval History Summary
  Future getListBranch() async {
    try {
      var token = await storage.read(key: 'user_token');
      var user_ucode = await storage.read(key: "user_ucode");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Response response = await api().get(
        Uri.parse(
            baseURLInternal + 'valuelists/branches/byuser/' + "$user_ucode"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);

        return list;
      }
    } catch (error) {
      // logger().e('error :: ${error}');
    }
  }

  //Request list CO and search
  Future getListCO(nameCO) async {
    try {
      var token = await storage.read(key: 'user_token');
      var user_ucode = await storage.read(key: "user_ucode");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Response response = await api().get(
        Uri.parse(baseURLInternal +
            'valuelists/users/co/' +
            "$user_ucode" +
            '/' +
            nameCO),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);
        logger().e("List : ${list}");
        return list;
      }
    } catch (error) {
      logger().e('error :: ${error}');
    }
  }

  //Request list CO and search
  Future getHistoryAPSARACO() async {
    try {
      var token = await storage.read(key: 'user_token');
      var user_ucode = await storage.read(key: "user_ucode");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Response response = await api().get(
        Uri.parse(baseURLInternal + 'ValueLists/Users/CO/' + "$user_ucode"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);
        return list;
      }
    } catch (error) {
      logger().e('error :: ${error}');
    }
  }

  Future getApprovalSummary(
      _pageSize, _pageNumber, status, code, bcode, sdate, edate) async {
    try {
      var token = await storage.read(key: 'user_token');
      var user_ucode = await storage.read(key: "user_ucode");
      var branch = await storage.read(key: "branch");
      var level = await storage.read(key: "level");
      var sdates = sdate != null ? sdate : '';
      var edates = edate != null ? edate : '';
      var codes = code != null ? code : '';
      status != null ? status : '';
      var btlcode = status != null ? status : '';
      var bcodes;
      var ucode;
      if (level == '3') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        btlcode = '';
        ucode = codes != null && codes != "" ? codes : "";
      }

      if (level == '2') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        btlcode = user_ucode;
        ucode = code != null && code != "" ? code : '';
      }

      if (level == '1') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        ucode = user_ucode;
        btlcode = '';
      }

      if (level == '4' || level == '5' || level == '6') {
        bcodes = bcode != null && bcode != "" ? bcode : '';
        btlcode = '';
        ucode = code != null && code != "" ? code : '';
      }
      // bodyRow =
      //     "{\n    \"pageSize\": $_pageSize,\n    \"pageNumber\": $_pageNumber,\n    \"ucode\": \"$ucode\",\n    \"bcode\": \"$bcodes\",\n    \"btlcode\": \"$btlcode\",\n    \"status\": \"\",\n    \"code\": \"\",\n    \"sdate\": \"$sdates\",\n    \"edate\": \"$edates\"\n}";

      final Map<String, dynamic> bodyRow = {
        "pageSize": "$_pageSize",
        "pageNumber": "$_pageNumber",
        "ucode": "$ucode",
        "bcode": "$bcodes",
        "btlcode": "$btlcode",
        "status": "",
        "code": "",
        "sdate": "$sdates",
        "edate": "$edates"
      };
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Response response = await api().post(
          Uri.parse(baseURLInternal + 'reports/loanapproval'),
          headers: headers,
          body: json.encode(bodyRow));
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);
        return list;
      }
    } catch (error) {
      logger().e('error :: ${error}');
    }
  }
}
