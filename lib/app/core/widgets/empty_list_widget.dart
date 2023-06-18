import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;

  const EmptyListWidget({
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
                color: const Color(0xFF777777),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF777777),
                  fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.titleLarge!.fontWeight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: const Color(0xFF777777),
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
