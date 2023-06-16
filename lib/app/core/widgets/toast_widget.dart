import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

showToastWidget({
  required BuildContext context,
  required String message,
  int seconds = 2,
}) {
  showToast(
    message,
    context: context,
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    duration: Duration(seconds: seconds),
    backgroundColor: Colors.black.withAlpha(200),
  );
}
