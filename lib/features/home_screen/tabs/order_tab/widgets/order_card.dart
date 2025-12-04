import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/orders/controller/orders_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import 'order_card_data.dart';
import 'order_card_title.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final OrderTabType tabType;

  const OrderCard({super.key, required this.order, required this.tabType});

  bool get isOrder => order.orderType == 'order';

  String _formatDate(String dateStr) {
    try {
      // Assuming format is "2025-11-26"
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        return '${parts[2]}/${parts[1]}/${parts[0]}';
      }
      return dateStr;
    } catch (e) {
      return dateStr;
    }
  }

  String _formatTime(String timeStr) {
    try {
      // Assuming format is "00:00:00" or "10:00:00"
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = parts[1];
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return '$displayHour:$minute $period';
      }
      return timeStr;
    } catch (e) {
      return timeStr;
    }
  }

  String _getServiceName(BuildContext context) {
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
    final s = S.of(context);
    return s.service_undefined;
  }

  String _getStatusText(BuildContext context) {
    final s = S.of(context);
    // Handle status based on order.status value
    switch (order.status) {
      case 'completed':
        return s.status_completed; // Completed - Green
      case 'in_progress':
        return s.status_in_progress; // In Progress - Light Blue
      case 'assigned':
        return s.status_assigned; // Assigned - Grey
      case 'pending':
        return s.status_pending; // Pending - Orange
      case 'cancelled':
        return s.status_cancelled; // Cancelled - Red
      default:
        return order.status;
    }
  }

  Color _getStatusColor() {
    // Handle status color based on order.status value
    switch (order.status) {
      case 'completed':
        return Colors.green; // Green for completed
      case 'in_progress':
        return const Color(0xFF00BCD4); // Light blue/cyan for in progress
      case 'assigned':
        return Colors.grey; // Grey for assigned
      case 'pending':
        return Colors.orange; // Orange for pending
      case 'cancelled':
        return Colors.red; // Red for cancelled
      default:
        return Colors.grey;
    }
  }

  String _getOrderNumber() {
    return '#KG${order.orderId.toString().padLeft(10, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final statusColor = _getStatusColor();
    final statusText = _getStatusText(context);

    return GestureDetector(
      onTap: () {
        if (tabType == OrderTabType.current) {
          GoRouter.of(
            context,
          ).push(AppRouter.serviceScreen, extra: {'order': order});
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.only(
          left: 24.w,
          right: 8.w,
          top: 14.h,
          bottom: 14.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffEAECF0)),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isOrder
                ? OrderCardTitle(
                    value: _getOrderNumber(),
                    title: s.order_number,
                  )
                : OrderCardTitle(
                    value: _getServiceName(context),
                    title: s.package,
                  ),
            SizedBox(height: 10.h),
            OrderCardData(
              field: s.date_label,
              value: _formatDate(order.orderDate),
            ),
            SizedBox(height: 6.h),
            OrderCardData(
              field: s.time_label,
              value: _formatTime(order.orderTime),
            ),
            SizedBox(height: 6.h),
            OrderCardData(
              field: s.service_label,
              value: _getServiceName(context),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Text(s.status_label, style: AppTextStyle.greyW600Size12Roboto),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
