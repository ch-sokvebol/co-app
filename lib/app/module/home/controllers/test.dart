// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class TestController extends GetxController {
//   Future<void> getTest() async {
//     String? url = 'http://localhost:4000/api/ActivityLog';
//     try {
//       http.get(Uri.parse(url), headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json'
//       }).then((res) {
//         if (res.statusCode == 200) {
//           debugPrint('okkkk=======>>>>>>>${res.body}');
//         } else {
//           debugPrint('okkkk=======>>>>>>>${res.statusCode}');
//         }
//       });
//     } catch (e) {
//     } finally {}
//   }

//   @override
//   void onInit() {
//     getTest();
//     super.onInit();
//   }
// }
