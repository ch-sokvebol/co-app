import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LampController extends GetxController {
  final isLoadingProvince = false.obs;
  List<dynamic> provinceList = [].obs;
  final txtProvince = ''.obs;
  Future<void> getProvince() async {
    isLoadingProvince(true);
    String url = dotenv.get('urlInternal');

    try {
      http.get(
        Uri.parse(url + 'addresses/province'),
        headers: {'Content-Type': 'application/json'},
      ).then((res) {
        var resJson = json.decode(res.body);
        provinceList = resJson;
        debugPrint('get prooo:$provinceList');
      });
    } catch (e) {
    } finally {}
  }
}
