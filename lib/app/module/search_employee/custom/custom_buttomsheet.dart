import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

onCustomShowBottomSheet({
  required BuildContext context,
  Function? ontab,
  Function? then,
  Widget? child,
  double? height,
  bool? appbar = false,
  Color? colors,
  bool isLoading = false,
  Widget? stack,
  String? title,
}) {
  CupertinoScaffold.showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: null,
      builder: (context) {
        return Material(
          color: colors ?? Colors.transparent.withOpacity(0),
          // color: Colors.blue,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: colors,
                // color: Colors.red,
              ),
              // padding: const EdgeInsets.only(
              //   top: 10,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (appbar == true)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back)),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            '$title',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: stack,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).then((value) {
    then!();
  });
}
