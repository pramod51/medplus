import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/search_report.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/utils/app_utils.dart';
import 'package:medplus/widgets/app_snackbar.dart';
import 'package:open_file/open_file.dart';

class ReportTile extends StatelessWidget {
  final ReportData data;
  final String userName;
  const ReportTile({
    Key? key,
    required this.data,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 15),
            height: 34,
            child: Row(
              children: [
                buildName(),
                const SizedBox(width: 12),
                ...buildUpdatedDate(),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: Color(0xffF8F8F8),
          ),
          Container(
            height: 58,
            padding: const EdgeInsets.only(left: 10, right: 17),
            child: Row(
              children: [
                buildReportCategory(),
                const SizedBox(width: 12),
                ...buildActions()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildName() {
    return Expanded(
      child: Text(
        userName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Palette.textColor,
        ),
      ),
    );
  }

  List<Widget> buildUpdatedDate() {
    return [
      const Text(
        'Upload Date:',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(width: 3),
      Text(
        data.updated_at,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      )
    ];
  }

  Widget buildReportCategory() {
    return Expanded(
      child: SizedBox(
        height: 25,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            height: 25,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            decoration: BoxDecoration(
                color: const Color(0xff948BFF),
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              data.categoryName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemCount: 1,
        ),
      ),
    );
  }

  List<Widget> buildActions() {
    return [
      GestureDetector(
        onTap: () async {
          final file = await getFileFromLocal();
          if (file != null) {
            OpenFile.open(file.path);
          }
        },
        child: SvgPicture.asset(
          Assets.ic_doc,
          color: Palette.buttonColor,
          height: 24,
          width: 24,
        ),
      ),
      const SizedBox(width: 15),
      GestureDetector(
        onTap: () async {
          final file = await getFileFromLocal();
          if (file != null) {
            AppUtils.shareFile(file);
          }
        },
        child: SvgPicture.asset(Assets.ic_share),
      ),
      const SizedBox(width: 15),
      GestureDetector(
        onTap: () async {
          if (await getFileFromLocal() != null) {
            AppSnackBar.onSuccess(
                'Yor repost downloaded inside Medplus folder');
          }
        },
        child: SvgPicture.asset(Assets.ic_download),
      ),
    ];
  }

  Future<File?> getFileFromLocal() async {
    final b = await AppUtils.hasAcceptedPermissions();
    if (!b) return null;
    final saveedPath = await AppUtils.reportsDirPath(
        fileName: userName + ' ' + data.categoryName,
        reportId: data.id.toString());

    File f = File(saveedPath);
    if (await f.exists()) {
      print('its there');
      return f;
    } else {
      final f = await Get.put(ApiService()).downloadReport(
          'https://www.clickdimensions.com/links/TestPDFfile.pdf',
          userName + ' ' + data.categoryName,
          data.id);
      return f;
    }
  }
}
