// import 'package:flutter/material.dart';

// import '../../../localizations/appLocalizations.dart';
// import '../../../utils/storages/colors.dart';
// import '../../module/search_employee/custom/custom_buttomsheet.dart';
// import '../../module/util/widget/custom_textfield.dart';
// import '../colors/app_color.dart';

// Widget bottomSheetDropDown(
//     {BuildContext? context, GestureTapCallback? onTabItem}) {
//   return GestureDetector(
//     onTap: () {
//       // controllerSearchCo.searchAllCO('');
//       onCustomShowBottomSheet(
//         then: () {},
//         ontab: () {},
//         appbar: true,
//         context: context!,
//         stack: Container(
//           padding: const EdgeInsets.only(right: 20, top: 15, left: 20),
//           child: CustomTextFieldNew(
//             hintText: 'Search Employee Name',
//             prefixIcon: Icon(
//               Icons.search,
//               color: AppColors.logolightGreen,
//             ),
//             borderColor: AppColors.logolightGreen.withOpacity(0.4),
//             onChange: (e) {
//               // controllerSearchCo.searchAllCO(e.toLowerCase());
//               // controllerSearchCo.update(controllerSearchCo.searchCoList);
//             },
//             hinTextColor: Colors.black54,
//           ),
//         ),
//         child: Container(
//           margin: EdgeInsets.only(bottom: 30),
//           child: SingleChildScrollView(
//             child: Container(
//               child: Obx(
//                 () => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: controllerSearchCo.searchCoList
//                       .asMap()
//                       .entries
//                       .map((e) => GestureDetector(
//                             onTap: () {
//                                onTabItem;
//                               // controllerSearchCo.isSelect.value = true;
//                               // controllerSearchCo.userName.value =
//                               //     e.value.uname!;
//                               // debugPrint(
//                               //     "ontap name :${controllerSearchCo.isSelect.value}");
//                               // debugPrint(
//                               //     "ontap name :${e.value.uname}");
//                               // debugPrint(
//                               //     "ontap id :${e.value.uid}");
//                               Navigator.pop(context);
                             
//                             },
//                             child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: 80,
//                               padding: EdgeInsets.only(
//                                 left: 20,
//                                 right: 20,
//                                 top: 10,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     '${e.value.uname}',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 6,
//                                   ),
//                                   Text(
//                                     '${e.value.ucode}',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 6,
//                                   ),
//                                   Divider(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     thickness: 1,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//     child: Container(
//       margin: EdgeInsets.only(left: 20, right: 20),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           width: 1,
//           color: logolightGreen,
//         ),
//       ),
//       child: Row(children: [
//         controllerSearchCo.isSelect.value == true
//             ? Text('${controllerSearchCo.userName.value}')
//             : Text(
//                 '${AppLocalizations.of(context)!.translate('employee_name')}',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//         Spacer(),
//         Icon(
//           Icons.arrow_drop_down,
//           color: Colors.black,
//         ),
//       ]),
//     ),
//   );
// }
