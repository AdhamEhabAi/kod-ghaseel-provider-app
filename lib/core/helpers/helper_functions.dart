
import 'dart:io';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';
import 'package:url_launcher/url_launcher.dart';


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

  /// Calculate distance between two coordinates using Haversine formula
  /// Returns distance in meters
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000; // Earth radius in meters

    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);

    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  static double _toRadians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

  /// Check if current time is valid for starting the service
  /// Returns true if current time is:
  /// - 15 minutes before the order's scheduled time, OR
  /// - At or after the order's scheduled time (time has passed)
  /// 
  /// This means the button is enabled if: now >= (orderDateTime - 15 minutes)
  static bool isOrderTimeValid(Order order) {
    final orderDateTime = parseOrderDateTime(order);
    if (orderDateTime == null) return false;

    final now = DateTime.now();
    
    // Calculate 15 minutes before the scheduled time
    final fifteenMinutesBefore = orderDateTime.subtract(const Duration(minutes: 15));
    
    // Allow starting the service if current time is at or after 15 minutes before scheduled time
    // This covers both cases:
    // 1. Starting 15 minutes before the order time
    // 2. Starting after the order time has passed
    return now.isAfter(fifteenMinutesBefore) || now.isAtSameMomentAs(fifteenMinutesBefore);
  }

  /// Format order date and time for display
  static String formatOrderDateTime(Order order) {
    try {
      final dateParts = order.orderDate.split('-');
      if (dateParts.length != 3) return '${order.orderDate} ${order.orderTime}';

      final timeParts = order.orderTime.split(':');
      if (timeParts.length < 2) return '${order.orderDate} ${order.orderTime}';

      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = timeParts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      return '${order.orderDate} ${displayHour.toString().padLeft(2, '0')}:$minute $period';
    } catch (e) {
      return '${order.orderDate} ${order.orderTime}';
    }
  }
  static String formatOrderDateTimeForService(Order order) {
    try {
      final dateParts = order.orderDate.split('-');
      if (dateParts.length != 3) return '${order.orderDate} ${order.orderTime}';

      final timeParts = order.orderTime.split(':');
      if (timeParts.length < 2) return '${order.orderDate} ${order.orderTime}';

      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = timeParts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      return '${displayHour.toString().padLeft(2, '0')}:$minute $period';
    } catch (e) {
      return '${order.orderDate} ${order.orderTime}';
    }
  }

  /// Format order date with day name and month name (e.g., "الخميس 10 اغسطس" or "Thursday, August 10")
  /// Uses the app's current locale (Arabic or English)
  static String formatOrderDateWithDayName(Order order) {
    try {
      final orderDateTime = parseOrderDateTime(order);
      if (orderDateTime == null) {
        return '${order.orderDate}';
      }

      // Use the app's locale (set by Intl.defaultLocale) or fallback to system locale
      final locale = Intl.defaultLocale ?? Intl.systemLocale;
      final isArabic = locale.startsWith('ar');
      
      // Format: Day name, Day number, Month name
      // For Arabic: "الخميس 10 اغسطس" (no comma)
      // For English: "Thursday, August 10" (with comma)
      String formatted;
      if (isArabic) {
        formatted = DateFormat('EEEE d MMMM', locale).format(orderDateTime);
      } else {
        // English format with comma: "Thursday, August 10"
        formatted = DateFormat('EEEE, d MMMM', locale).format(orderDateTime);
      }
      
      return formatted;
    } catch (e) {
      return '${order.orderDate}';
    }
  }

  /// Map hex color value to color name
  /// Returns color name localized based on app locale
  /// Check if an order is completed
  static bool isOrderCompleted(Order order) {
    // Order is completed if completedAt is not null
    return order.completedAt != null && order.completedAt!.isNotEmpty;
  }

  static String getColorNameFromHex(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) return '';
    
    // Normalize the hex value (remove spaces, handle different formats)
    // Handle different formats: "0xFF000000", "#FF000000", "FF000000", "0XFF000000", etc.
    String normalizedHex = hexColor.trim();
    
    // Remove # if present
    if (normalizedHex.startsWith('#')) {
      normalizedHex = normalizedHex.substring(1);
    }
    
    // Normalize to lowercase first, then handle the prefix
    normalizedHex = normalizedHex.toLowerCase();
    
    // Ensure we have the 0x prefix (lowercase x)
    if (!normalizedHex.startsWith('0x')) {
      if (normalizedHex.length == 8) {
        normalizedHex = '0x$normalizedHex';
      } else if (normalizedHex.length == 6) {
        // If it's 6 digits, add FF for alpha channel
        normalizedHex = '0xff$normalizedHex';
      }
    }
    
    // Now convert hex digits to uppercase (but keep 'x' lowercase)
    if (normalizedHex.startsWith('0x')) {
      final hexDigits = normalizedHex.substring(2).toUpperCase();
      normalizedHex = '0x$hexDigits';
    }
    
    // Get current locale
    final locale = Intl.defaultLocale ?? Intl.systemLocale;
    final isArabic = locale.startsWith('ar');
    
    // Map hex values to color names (English) - keys use lowercase 'x'
    const colorMapEn = {
      '0xFF000000': 'Black',
      '0xFFFFFFFF': 'White',
      '0xFF808080': 'Grey',
      '0xFFB0B0B0': 'Silver',
      '0xFF2C3E50': 'Dark Slate',
      '0xFF0000FF': 'Blue',
      '0xFF0A3D62': 'Deep Blue',
      '0xFFFF0000': 'Red',
      '0xFF8B0000': 'Maroon',
      '0xFF2ECC71': 'Green',
      '0xFF7B3F00': 'Brown',
      '0xFFFFC107': 'Gold',
      '0xFFFFA500': 'Orange',
      '0xFFEEE8AA': 'Cream',
      '0xFF4B0082': 'Indigo',
    };
    
    // Map hex values to color names (Arabic) - keys use lowercase 'x'
    const colorMapAr = {
      '0xFF000000': 'أسود',
      '0xFFFFFFFF': 'أبيض',
      '0xFF808080': 'رمادي',
      '0xFFB0B0B0': 'فضي',
      '0xFF2C3E50': 'أردوازي داكن',
      '0xFF0000FF': 'أزرق',
      '0xFF0A3D62': 'أزرق داكن',
      '0xFFFF0000': 'أحمر',
      '0xFF8B0000': 'كستنائي',
      '0xFF2ECC71': 'أخضر',
      '0xFF7B3F00': 'بني',
      '0xFFFFC107': 'ذهبي',
      '0xFFFFA500': 'برتقالي',
      '0xFFEEE8AA': 'كريمي',
      '0xFF4B0082': 'نيلي',
    };
    
    final colorMap = isArabic ? colorMapAr : colorMapEn;
    final colorName = colorMap[normalizedHex];
    
    return colorName ?? hexColor;
  }

  /// Format car data for display (e.g., "تويوتا كامري 2022 - أبيض - أ ب ج 123")
  /// Format: Manufacturer Model [Year] - Color - Plate Number
  static String formatCarData(Order order) {
    final parts = <String>[];
    
    // Add manufacturer and model
    if (order.carManufacturerName != null && order.carManufacturerName!.isNotEmpty) {
      parts.add(order.carManufacturerName!);
    }
    if (order.carModelName != null && order.carModelName!.isNotEmpty) {
      parts.add(order.carModelName!);
    }
    
    // Note: Year might not be available in the order, but if it is, add it
    // For now, we'll just use manufacturer and model
    
    String carInfo = parts.join(' ');
    
    // Add color (convert hex to color name)
    if (order.carColor != null && order.carColor!.isNotEmpty) {
      final colorName = getColorNameFromHex(order.carColor);
      if (colorName.isNotEmpty) {
        if (carInfo.isNotEmpty) {
          carInfo += ' - $colorName';
        } else {
          carInfo = colorName;
        }
      }
    }
    
    // Add plate number
    if (order.plateNumber != null && order.plateNumber!.isNotEmpty) {
      if (carInfo.isNotEmpty) {
        carInfo += ' - ${order.plateNumber}';
      } else {
        carInfo = order.plateNumber!;
      }
    }
    
    return carInfo.isEmpty ? '' : carInfo;
  }

  static Future<void> openGoogleMapsNavigation(
    double latitude,
    double longitude,
  ) async {
    try {
      String url;
      
      if (Platform.isAndroid) {
        url = 'google.navigation:q=$latitude,$longitude';
      } else if (Platform.isIOS) {
        url = 'comgooglemaps://?daddr=$latitude,$longitude&directionsmode=driving';
      } else {
        url = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
      }

      final uri = Uri.parse(url);
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        final webUrl = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
        );
        if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('Could not launch Google Maps');
        }
      }
    } catch (e) {
      throw Exception('Error opening Google Maps: $e');
    }
  }
}


