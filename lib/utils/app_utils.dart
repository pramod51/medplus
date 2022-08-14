import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class AppUtils {
  AppUtils._();
  static void downloadFile(String url) {}

  static void shareFile(File? file, [String? text]) {
    if (file == null) return;
    Share.shareFiles([file.path], text: text);
  }

  static Future<bool> hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      print('------------------------');
      print(await Permission.camera.status.isGranted);
      print(await Permission.storage.status.isGranted);
      print(await Permission.accessMediaLocation.status.isGranted);
      print('------------------------');
      if (await requestPermission(Permission.camera) &&
              await requestPermission(Permission.storage) &&
              await requestPermission(Permission.accessMediaLocation)
          // manage external storage needed for android 11/R
          // await requestPermission(Permission.manageExternalStorage)
          ) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      print('------------------------');
      print(await Permission.camera.status.isGranted);
      print(await Permission.storage.status.isGranted);
      print(await Permission.photos.status.isGranted);
      print('------------------------');
      if (await requestPermission(Permission.photos) &&
          await requestPermission(Permission.storage)) {
        return true;
      } else {
        return false;
      }
    } else {
      // not android or ios
      return false;
    }
  }

  static Future<bool> requestPermission(Permission permission) async {
    final req = await permission.request();
    return req.isGranted;
  }

  static Future<String> reportsDirPath(
      {required String fileName, String reportId = ''}) async {
    await hasAcceptedPermissions();
    final dir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final path = Platform.isAndroid
        ? '/storage/emulated/0/Medplus/$fileName Report $reportId.pdf'
        : ('${dir?.path}/$fileName Report $reportId.pdf');
    if (Platform.isAndroid) {
      if (!await Directory('/storage/emulated/0/Medplus').exists()) {
        Directory('/storage/emulated/0/Medplus').create();
      }
    }
    // else {
    //   if (!await Directory('${dir!.path}/Medplus').exists()) {
    //     Directory('${dir.path}/Medplus').create();
    //   }
    // }
    return path;
  }

  static String getFormattedDate(String date) {
    /// Convert into local date format.
    // var localDate = DateTime.parse(date).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('dd/MM/yyyy');
    var inputDate = inputFormat.parse(date);

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
}

extension DateTimeToStringExtension on DateTime {
/*
    ICU Name                   Skeleton
    --------                   --------
    DAY                          d
    ABBR_WEEKDAY                 E
    WEEKDAY                      EEEE
    ABBR_STANDALONE_MONTH        LLL
    STANDALONE_MONTH             LLLL
    NUM_MONTH                    M
    NUM_MONTH_DAY                Md
    NUM_MONTH_WEEKDAY_DAY        MEd
    ABBR_MONTH                   MMM
    ABBR_MONTH_DAY               MMMd
    ABBR_MONTH_WEEKDAY_DAY       MMMEd
    MONTH                        MMMM
    MONTH_DAY                    MMMMd
    MONTH_WEEKDAY_DAY            MMMMEEEEd
    ABBR_QUARTER                 QQQ
    QUARTER                      QQQQ
    YEAR                         y
    YEAR_NUM_MONTH               yM
    YEAR_NUM_MONTH_DAY           yMd
    YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
    YEAR_ABBR_MONTH              yMMM
    YEAR_ABBR_MONTH_DAY          yMMMd
    YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
    YEAR_MONTH                   yMMMM
    YEAR_MONTH_DAY               yMMMMd
    YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
    YEAR_ABBR_QUARTER            yQQQ
    YEAR_QUARTER                 yQQQQ
    HOUR24                       H
    HOUR24_MINUTE                Hm
    HOUR24_MINUTE_SECOND         Hms
    HOUR                         j
    HOUR_MINUTE                  jm
    HOUR_MINUTE_SECOND           jms
    HOUR_MINUTE_GENERIC_TZ       jmv
    HOUR_MINUTE_TZ               jmz
    HOUR_GENERIC_TZ              jv
    HOUR_TZ                      jz
    MINUTE                       m
    MINUTE_SECOND                ms
    SECOND                       s
   */
  String format(String format) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }
}

extension StringExtensions on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return this != null && this!.isNotEmpty;
  }

  String _interpolate(String string, List<String> params) {
    String result = string;
    for (int i = 1; i < params.length + 1; i++) {
      result = result.replaceAll('%${i}s', params[i - 1]);
    }
    return result;
  }

  String format(List<String> params) => _interpolate(this!, params);
}
