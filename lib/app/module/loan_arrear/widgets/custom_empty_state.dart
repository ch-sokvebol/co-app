import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomEmptyState extends StatelessWidget {
  final String? title, description;

  const CustomEmptyState({super.key, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        FaIcon(
          FontAwesomeIcons.circleExclamation,
          size: 50,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          title ?? '',
          style:
              theme.displayMedium!.copyWith(fontSize: 22, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        Text(description ?? '', style: theme.labelLarge),
      ],
    );
  }
}
