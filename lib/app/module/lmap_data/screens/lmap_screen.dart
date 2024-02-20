import 'package:chokchey_finance/app/module/lmap_data/controllers/lamp_controller.dart';
import 'package:chokchey_finance/app/utils/helpers/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LmapScreen extends StatelessWidget {
  const LmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(LampController());
    con.getProvince();
    return CupertinoScaffold(
      body: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: Obx(
            () => Column(children: [
              // DropDownLmapRegister(
              //                   elevation: 0,
              //                   icons: null,
              //                   validate: validateVillage
              //                       ? RoundedRectangleBorder(
              //                           side: BorderSide(
              //                               color: Colors.red, width: 1),
              //                           borderRadius: BorderRadius.circular(10),
              //                         )
              //                       : RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                   onInSidePress: () async {
              //                     FocusScope.of(context)
              //                         .unfocus(disposition: disposition);
              //                     final storage = new FlutterSecureStorage();
              //                     var token =
              //                         await storage.read(key: 'user_token');
              //                     var list;
              //                     try {
              //                       final Response response = await api().get(
              //                         Uri.parse(baseURLInternal +
              //                             'addresses/province'),
              //                         headers: {
              //                           "Content-Type": "application/json",
              //                         },
              //                       );
              //                       list = jsonDecode(response.body);
              //                       setState(() {
              //                         stateProvince = list ?? '';
              //                       });
              //                     } catch (error) {}
              //                     // Province
              //                     SelectDialog.showModal<String>(
              //                       context,
              //                       label: AppLocalizations.of(context)!
              //                               .translate('search') ??
              //                           'Search',
              //                       items: List.generate(list.length,
              //                           (index) => "${list[index]}"),
              //                       onChange: (value) async {
              //                         if (mounted) {
              //                           FocusScope.of(context)
              //                               .unfocus(disposition: disposition);
              //                           setState(() {
              //                             // Province1
              //                             selectedValueProvince = value;
              //                             selectedValueDistrict = "ស្រុក/ខណ្ឌ";
              //                             selectedValueCommune = "ឃុំ/សងា្កត់";
              //                             _onSelectVillageDisplay = "ភូមិ";
              //                             selectedValueVillage = null;
              //                             districtreadOnlys = true;
              //                           });
              //                           myModel.clearLmap();
              //                         }
              //                       },
              //                     );
              //                   },
              //                   selectedValue: selectedValueProvince,
              //                   texts: selectedValueProvince != null
              //                       ? selectedValueProvince
              //                       : "ខេត្ត/ក្រុង",
              //                   title: selectedValueProvince != null
              //                       ? selectedValueProvince
              //                       : "ខេត្ត/ក្រុង",
              //                   clear: true,
              //                   readOnlys: true,
              //                   iconsClose: Icon(Icons.close),
              //                   onPressed: () {
              //                     if (mounted) {
              //                       debugPrint("12345");
              //                       FocusScope.of(context)
              //                           .unfocus(disposition: disposition);
              //                       setState(() {
              //                         selectedValueProvince = "ខេត្ត/ក្រុង";
              //                         selectedValueDistrict = "ស្រុក/ខណ្ឌ";
              //                         selectedValueCommune = "ឃុំ/សងា្កត់";
              //                         _onSelectVillageDisplay = "ភូមិ";
              //                         selectedValueVillage = null;
              //                         districtreadOnlys = false;
              //                         communereadOnlys = false;
              //                         villagereadOnlys = false;
              //                         myModel.clearLmap();
              //                       });
              //                     }
              //                   },
              //                   styleTexts: selectedValueProvince != ''
              //                       ? TextStyle(
              //                           fontFamily: fontFamily,
              //                           fontSize: fontSizeXs,
              //                           color: Colors.black,
              //                           fontWeight: fontWeight500)
              //                       : TextStyle(
              //                           fontFamily: fontFamily,
              //                           fontSize: fontSizeXs,
              //                           color: Colors.grey,
              //                           fontWeight: fontWeight500),
              //                 ),
              // CustomDropDown(
              //   label: 'province',
              //   item: [
              //     ...con.provinceList.asMap().entries.map((e) {
              //       return DropDownItem(
              //         itemList: {
              //           "Name": e.value,
              //         },
              //       );
              //     })
              //   ],
              //   onChange: (pr) {
              //     con.txtProvince.value = pr["Name"];
              //   },
              //   defaultValue: {"Name": con.txtProvince.value},
              // ),
              CustomDropDown(
                label: 'district',
                item: [],
              ),
              CustomDropDown(
                label: 'commun',
                item: [],
              ),
              CustomDropDown(
                label: 'village',
                item: [],
              ),
            ]),
          ),
        );
      }),
    );
  }
}
