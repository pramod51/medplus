import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/widgets/app_button.dart';

class NoDataScreen extends StatelessWidget {
  final String? message;
  const NoDataScreen({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(
        message ?? 'No data available',
        style: const TextStyle(
          color: Palette.textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String? message;

  final VoidCallback? onTryAgain;

  const ErrorScreen({
    Key? key,
    this.message,
    this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message ?? 'Server Error',
            style: const TextStyle(
              color: Palette.textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          if (onTryAgain != null) ...[
            AppElevatedBtn(
              text: 'Try Again',
              onPressed: onTryAgain,
            ),
          ]
        ],
      ),
    );
  }
}
