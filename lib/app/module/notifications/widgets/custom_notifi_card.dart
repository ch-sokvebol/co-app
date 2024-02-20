import 'package:flutter/material.dart';

import '../../../utils/colors/app_color.dart';

class CustomNotifiCard extends StatelessWidget {
  final String? title, body;
  final Widget? icon;
  const CustomNotifiCard({super.key, this.title, this.body, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
          child: Row(
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.logoDarkBlue),
                  child: Center(child: icon)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${title}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        '${body}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              // Spacer(),
              // Padding(
              //   padding: const EdgeInsets.only(right: 20),
              //   child: Text(
              //     '12m',
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodySmall!
              //         .copyWith(
              //           fontSize: 14,
              //           // color: AppColors.logoDarkBlue,
              //         ),
              //   ),
              // ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       if (con.allnotiModel.value
              //               .listMessages![index].mstatus ==
              //           1)
              //         Icon(
              //           Icons.done_all,
              //           size: 15,
              //         ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        Divider(
          thickness: 0.5,
          color: AppColors.logoDarkBlue,
        )
      ],
    );
  }
}
