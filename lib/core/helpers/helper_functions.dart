
import 'package:intl/intl.dart';


class HelperFunctions {


  static Future<void> launchURL(String url) async {
    // try {
    //   if (url.isEmpty) return;
    //
    //   final Uri uri = Uri.parse(url);
    //
    //   if (!['http', 'https'].contains(uri.scheme)) {
    //     debugPrint('🚫 Invalid URL scheme: $url');
    //     return;
    //   }
    //
    //   if (!await canLaunchUrl(uri)) {
    //     debugPrint('🚫 No app found to open: $url');
    //     return;
    //   }
    //
    //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    //     debugPrint('⚠️ Failed to launch URL: $url');
    //   }
    // } catch (e) {
    //   debugPrint('🚨 Error launching URL: $e');
    // }
  }
  static List<Map<String, dynamic>> generateTimeSlots(DateTime date) {
    final now = DateTime.now();

    DateTime start = DateTime(
      date.year,
      date.month,
      date.day,
      (date.year == now.year && date.month == now.month && date.day == now.day)
          ? now.hour + 1
          : 0,
    );

    DateTime end = DateTime(date.year, date.month, date.day, 23, 59);

    final List<Map<String, dynamic>> slots = [];
    DateTime temp = start;

    while (temp.isBefore(end)) {
      String formatted = DateFormat.jm().format(temp);

      bool isDisabled = false;
      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        isDisabled = temp.isBefore(now.add(const Duration(hours: 2)));
      }

      slots.add({"time": formatted, "disabled": isDisabled});

      temp = temp.add(const Duration(hours: 1));
    }

    return slots;
  }

}


