import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';

class ListEmptyWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;

  const ListEmptyWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 100,
                color: ColorsConstants.textLight,
              ),
              Text(
                title,
                style: TextStyle(
                  color: ColorsConstants.textLight,
                  fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.titleLarge!.fontWeight,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: ColorsConstants.textLight,
                  fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.labelLarge!.fontWeight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
