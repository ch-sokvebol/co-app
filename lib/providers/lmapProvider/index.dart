import 'dart:convert';

import 'package:chokchey_finance/providers/manageService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LmapProvider with ChangeNotifier {
  var parsed = [];

  Future clearLmap() async {
    parsed = [];
    notifyListeners();
  }

  Future getLmap({
    pageSize,
    province,
    district,
    commune,
    village,
  }) async {
    try {
      //   http
      //       .post(Uri.parse(baseURLInternal + 'LMap/lmap'),
      //           headers: {'Content-Type': 'application/json'},
      //           body: json.encode({
      //             "pageSize": "$pageSize",
      //             "pageNumber": "1",
      //             "province": "$province",
      //             "district": "$district",
      //             "commune": "$commune",
      //             "village": "$village".substring('$village'.length - 8)
      //           }))
      //       .then((res) {
      //     if (res.statusCode == 200) {
      //       var resJson = json.decode(res.body);
      //       debugPrint('lam res:::::+++++${res.body}');
      //       notifyListeners();
      //     } else {
      //       parsed = [];
      //       notifyListeners();
      //     }
      //   });
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse(baseURLInternal + 'LMap/lmap'));

      var result = "$village".split('-');
      request.body = json.encode({
        "pageSize": "$pageSize",
        "pageNumber": "1",
        "province": "$province",
        "district": "$district",
        "commune": "$commune",
        "village": result[1]
      });
      debugPrint('sub========:$village');
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        parsed = jsonDecode(await response.stream.bytesToString());
        notifyListeners();
      } else {
        parsed = [];
        notifyListeners();
      }
    } catch (error) {
      parsed = [];
      notifyListeners();
    }
  }
}
