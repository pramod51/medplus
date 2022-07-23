import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  AppSnackBar._();

  static const longDuration = Duration(seconds: 10);

  static _showDismissibleSnackBar(
    String? message, {
    Icon? icon,
    Duration duration = const Duration(seconds: 3),
    bool isDismissible = true,
    String? actionableText,
    VoidCallback? onActionableTextedClicked,
    Color color = Colors.red,
  }) {
    if (Get.isSnackbarOpen == true) {
      return;
    }
    // Get.showSnackbar(snackbar)
    var bar = GetSnackBar(
      messageText: Row(
        children: [
          Expanded(
            child: Text(
              message ?? "null",
              style: Get.textTheme.bodyText2?.copyWith(color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
          if (actionableText != null)
            SizedBox(
              height: 28,
              child: OutlinedButton(
                onPressed: () {
                  if (Get.isSnackbarOpen == true) {
                    Get.back();
                  }
                  onActionableTextedClicked?.call();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  side: MaterialStateProperty.resolveWith(
                    (states) => const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Text(
                  actionableText,
                  style: Get.textTheme.bodyText1?.copyWith(color: Colors.white),
                ),
              ),
            )
        ],
      ),
      icon: icon,
      backgroundColor: color,
      barBlur: 20,
      margin: const EdgeInsets.all(15),
      overlayBlur: 0.0,
      overlayColor: Colors.transparent,
      borderRadius: 8,
      isDismissible: true,
      duration: duration,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      forwardAnimationCurve: Curves.easeInCubic,
      reverseAnimationCurve: Curves.easeInOut,
      maxWidth: 360,
      animationDuration: const Duration(milliseconds: 300),
    );

    Get.showSnackbar(bar);
  }

  static onSuccess(
    String? message, {
    Icon? icon,
    Duration duration = const Duration(seconds: 5),
    bool isDismissible = true,
    String? actionableText,
    VoidCallback? onActionableTextedClicked,
  }) {
    _showDismissibleSnackBar(
      message,
      icon: icon,
      duration: duration,
      isDismissible: isDismissible,
      actionableText: actionableText,
      onActionableTextedClicked: onActionableTextedClicked,
      color: Colors.green,
    );
  }

  static onError(
    String? message, {
    Icon? icon,
    Duration duration = const Duration(seconds: 5),
    bool isDismissible = true,
    String? actionableText,
    VoidCallback? onActionableTextedClicked,
  }) {
    _showDismissibleSnackBar(
      message,
      icon: icon,
      duration: duration,
      isDismissible: isDismissible,
      actionableText: actionableText,
      onActionableTextedClicked: onActionableTextedClicked,
      color: Colors.red,
    );
  }
}
