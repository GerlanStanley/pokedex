import 'package:flutter/material.dart';

import 'primary_elevated_button_widget.dart';

class FailureWidget extends StatelessWidget {
  final String message;
  final Function()? onPressed;
  final bool white;

  const FailureWidget({
    Key? key,
    required this.message,
    this.onPressed,
    required this.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: white
                  ? Theme.of(context).textTheme.titleSmall?.color
                  : const Color(0xFF555555),
              size: 80,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                'Ops',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight:
                      Theme.of(context).textTheme.titleSmall!.fontWeight,
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  color: white
                      ? Theme.of(context).textTheme.titleSmall!.color
                      : const Color(0xFF555555),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight:
                      Theme.of(context).textTheme.bodyMedium!.fontWeight,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: white
                      ? Theme.of(context).textTheme.bodyMedium!.color
                      : const Color(0xFF555555),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: PrimaryElevatedButtonWidget(
                text: 'Tentar novamente',
                onPressed: onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
