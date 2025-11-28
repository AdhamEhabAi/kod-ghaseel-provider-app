
import 'package:intl/intl.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';


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
  static DateTime? parseOrderDateTime(Order order) {
    try {
      final dateParts = order.orderDate.split('-');
      if (dateParts.length != 3) return null;

      final timeParts = order.orderTime.split(':');
      if (timeParts.length < 2) return null;

      final year = int.tryParse(dateParts[0]) ?? DateTime.now().year;
      final month = int.tryParse(dateParts[1]) ?? DateTime.now().month;
      final day = int.tryParse(dateParts[2]) ?? DateTime.now().day;
      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = int.tryParse(timeParts[1]) ?? 0;

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  static bool isWithinOneHour(Order order) {
    final orderDateTime = parseOrderDateTime(order);
    if (orderDateTime == null) return false;

    final now = DateTime.now();
    final difference = orderDateTime.difference(now);

    return difference.inMinutes >= 0 && difference.inMinutes <= 60;
  }

  static String getServiceDescription(Order order) {
    if (order.serviceName != null && order.serviceName!.isNotEmpty) {
      return order.serviceName!;
    } else if (order.packageServiceName != null &&
        order.packageServiceName!.isNotEmpty) {
      return order.packageServiceName!;
    } else if (order.packageName != null && order.packageName!.isNotEmpty) {
      return order.packageName!;
    } else if (order.companyPackageName != null &&
        order.companyPackageName!.isNotEmpty) {
      return order.companyPackageName!;
    }
    return '';
  }

}


