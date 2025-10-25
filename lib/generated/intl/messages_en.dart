// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(minutes, seconds) =>
      "You can’t enable yet. ${minutes}m ${seconds}s left";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'No completed orders', one: '1 order completed', other: '${count} orders completed')}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'daily orders', one: 'daily order', other: 'daily orders')}";

  static String m3(count) => "${count} days ago";

  static String m4(count) => "From ${count} orders";

  static String m5(name) => "Hello ${name} 👋";

  static String m6(count) => "${count} min";

  static String m7(count) => "${count} min to finish";

  static String m8(count) =>
      "${Intl.plural(count, zero: 'orders', one: 'order', other: 'orders')}";

  static String m9(service, time) => "${service} - ${time}";

  static String m10(from, to) => "${from} - ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutUs": MessageLookupByLibrary.simpleMessage("About us"),
    "acceptance_rate": MessageLookupByLibrary.simpleMessage("Acceptance rate"),
    "acceptance_rate_excellent": MessageLookupByLibrary.simpleMessage(
      "Excellent",
    ),
    "acceptance_rate_title": MessageLookupByLibrary.simpleMessage(
      "Acceptance rate",
    ),
    "add_personal_email": MessageLookupByLibrary.simpleMessage(
      "Add personal email",
    ),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Kod Ghaseel"),
    "apply_filter": MessageLookupByLibrary.simpleMessage("Apply Filter"),
    "autoEnabledSnackbar": MessageLookupByLibrary.simpleMessage(
      "Availability auto-enabled",
    ),
    "avg_order": MessageLookupByLibrary.simpleMessage("Average Order"),
    "browseAsGuest": MessageLookupByLibrary.simpleMessage("Login as Guest"),
    "cannotEnableYet": m0,
    "carServiceDescription": MessageLookupByLibrary.simpleMessage(
      "Toyota Camry - full wash - 2.5 km",
    ),
    "carTipsAndSolutions": MessageLookupByLibrary.simpleMessage(
      "Tips and tricks to keep your car clean",
    ),
    "car_data": MessageLookupByLibrary.simpleMessage(
      "Toyota Camry 2022 - White - A B J 123",
    ),
    "change_language": MessageLookupByLibrary.simpleMessage("Change Language"),
    "client": MessageLookupByLibrary.simpleMessage("Client"),
    "codeResentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Verification code resent successfully",
    ),
    "completed": MessageLookupByLibrary.simpleMessage("completed"),
    "completed_orders": m1,
    "cookies_policy": MessageLookupByLibrary.simpleMessage("Cookies Policy"),
    "currency_sar": MessageLookupByLibrary.simpleMessage("SAR"),
    "currentOrder": MessageLookupByLibrary.simpleMessage("current order"),
    "daily": MessageLookupByLibrary.simpleMessage("Daily"),
    "daily_orders": m2,
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "date_label": MessageLookupByLibrary.simpleMessage("Date"),
    "day_and_time": MessageLookupByLibrary.simpleMessage("Day and Time"),
    "day_time_for_service": MessageLookupByLibrary.simpleMessage(
      "Thursday, August 10",
    ),
    "daysAgo": m3,
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "didNotReceiveCode": MessageLookupByLibrary.simpleMessage(
      "Didn’t receive the code? ",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "enableNotificationDescription": MessageLookupByLibrary.simpleMessage(
      "Be the first to know about offers and new services... Enable notifications and stay ready!",
    ),
    "enableNotifications": MessageLookupByLibrary.simpleMessage(
      "Enable Notifications",
    ),
    "enterCode": MessageLookupByLibrary.simpleMessage("Enter the code"),
    "enterMinutesHint": MessageLookupByLibrary.simpleMessage("Enter minutes"),
    "enterYourName": MessageLookupByLibrary.simpleMessage("Enter your name..."),
    "enterYourPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Please enter your phone number",
    ),
    "exclusiveDiscounts": MessageLookupByLibrary.simpleMessage(
      "Exclusive discounts for you",
    ),
    "faq_a_payment_methods_list": MessageLookupByLibrary.simpleMessage(
      "Credit & debit cards (Visa, Mastercard)",
    ),
    "faq_a_quick_booking_time": MessageLookupByLibrary.simpleMessage(
      "Quick booking: 15–30 minutes",
    ),
    "faq_bullet_peak": MessageLookupByLibrary.simpleMessage(
      "Peak times: it may take up to 45 minutes",
    ),
    "faq_bullet_scheduled": MessageLookupByLibrary.simpleMessage(
      "Scheduled booking: according to your selected time",
    ),
    "faq_did_this_help": MessageLookupByLibrary.simpleMessage(
      "Did this solve your issue?",
    ),
    "faq_q_how_long_arrive": MessageLookupByLibrary.simpleMessage(
      "How long does it take you to arrive?",
    ),
    "faq_q_payment_methods": MessageLookupByLibrary.simpleMessage(
      "What payment methods are available?",
    ),
    "faq_search_hint": MessageLookupByLibrary.simpleMessage(
      "Search for what’s on your mind…",
    ),
    "faq_title": MessageLookupByLibrary.simpleMessage(
      "Frequently Asked Questions",
    ),
    "fastOffersAndAlerts": MessageLookupByLibrary.simpleMessage(
      "Quick offers and alerts you won’t miss",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "filter": MessageLookupByLibrary.simpleMessage("Filter"),
    "filter_apply": MessageLookupByLibrary.simpleMessage("Apply filter"),
    "filter_opt_12_3": MessageLookupByLibrary.simpleMessage(
      "Orders from 12 to 3",
    ),
    "filter_opt_3_6": MessageLookupByLibrary.simpleMessage(
      "Orders from 3 to 6",
    ),
    "filter_opt_6_9": MessageLookupByLibrary.simpleMessage(
      "Orders from 6 to 9",
    ),
    "filter_opt_9_12": MessageLookupByLibrary.simpleMessage(
      "Orders from 9 to 12",
    ),
    "filter_title": MessageLookupByLibrary.simpleMessage("Filter orders"),
    "finishService": MessageLookupByLibrary.simpleMessage("Finish service"),
    "from_orders": m4,
    "getVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Get Verification Code",
    ),
    "gold_plan": MessageLookupByLibrary.simpleMessage("Gold plan"),
    "helloName": m5,
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "invalidMinutesMsg": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid number of minutes",
    ),
    "keep_it_up": MessageLookupByLibrary.simpleMessage("Keep it up!"),
    "last_earnings": MessageLookupByLibrary.simpleMessage("Last Earnings"),
    "later": MessageLookupByLibrary.simpleMessage("Later"),
    "location_disabled": MessageLookupByLibrary.simpleMessage(
      "Location sharing disabled. Tap here to enable.",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Log In."),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage("Yes, sure!"),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Log out!"),
    "mapAddress": MessageLookupByLibrary.simpleMessage(
      "King Fahd Street, Riyadh",
    ),
    "markAsRead": MessageLookupByLibrary.simpleMessage("Mark as read"),
    "mark_as_read": MessageLookupByLibrary.simpleMessage("Mark as read"),
    "monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
    "nMinutes": m6,
    "nMinutesToFinish": m7,
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "no_internet": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "notification1Subtitle": MessageLookupByLibrary.simpleMessage(
      "Enjoy shopping while we clean it.",
    ),
    "notification1Title": MessageLookupByLibrary.simpleMessage(
      "Your car wash has started! 🚗",
    ),
    "notification2Subtitle": MessageLookupByLibrary.simpleMessage(
      "The wash is complete successfully.",
    ),
    "notification2Title": MessageLookupByLibrary.simpleMessage(
      "Your car is sparkling clean! ✨",
    ),
    "notification3Subtitle": MessageLookupByLibrary.simpleMessage(
      "Book your next wash now.",
    ),
    "notification3Title": MessageLookupByLibrary.simpleMessage(
      "Your car has been delivered! 🌺",
    ),
    "notification4Subtitle": MessageLookupByLibrary.simpleMessage(
      "Our driver is on the way to pick up the car.",
    ),
    "notification4Title": MessageLookupByLibrary.simpleMessage(
      "Your order is being processed 🧽",
    ),
    "notification5Subtitle": MessageLookupByLibrary.simpleMessage(
      "Your car will be washed regularly.",
    ),
    "notification5Title": MessageLookupByLibrary.simpleMessage(
      "Your subscription is active! 🧼",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsTitle": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notifications_messages": MessageLookupByLibrary.simpleMessage(
      "Message notifications",
    ),
    "notifications_offers": MessageLookupByLibrary.simpleMessage(
      "Offer notifications",
    ),
    "notifications_payment": MessageLookupByLibrary.simpleMessage(
      "Payment notifications",
    ),
    "notifications_reminders": MessageLookupByLibrary.simpleMessage(
      "Reminder notifications",
    ),
    "notifications_title": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "onboardingDescription": MessageLookupByLibrary.simpleMessage(
      "A mobile car wash service that comes to you, provided by a qualified and equipped team.",
    ),
    "oneHour": MessageLookupByLibrary.simpleMessage("1 hour"),
    "orderProgressTitle": MessageLookupByLibrary.simpleMessage(
      "Order progress",
    ),
    "order_number": MessageLookupByLibrary.simpleMessage("Order No."),
    "orders_count": m8,
    "orders_current": MessageLookupByLibrary.simpleMessage("Current"),
    "orders_past": MessageLookupByLibrary.simpleMessage("Past"),
    "orders_so_far_title": MessageLookupByLibrary.simpleMessage(
      "Number of orders so far",
    ),
    "orders_title": MessageLookupByLibrary.simpleMessage("Orders"),
    "orders_upcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "package": MessageLookupByLibrary.simpleMessage("Package"),
    "package_silver": MessageLookupByLibrary.simpleMessage("Silver"),
    "packages": MessageLookupByLibrary.simpleMessage("Packages"),
    "pauseTemporarily": MessageLookupByLibrary.simpleMessage("Pause"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "phoneNumberHint": MessageLookupByLibrary.simpleMessage("0000..."),
    "previousOrders": MessageLookupByLibrary.simpleMessage("previous orders"),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacy_title": MessageLookupByLibrary.simpleMessage("Privacy"),
    "profile_email": MessageLookupByLibrary.simpleMessage("Email address"),
    "profile_name_sample": MessageLookupByLibrary.simpleMessage("Sara Mohamed"),
    "profile_phone": MessageLookupByLibrary.simpleMessage("Phone number"),
    "profile_title": MessageLookupByLibrary.simpleMessage("My profile"),
    "profile_username": MessageLookupByLibrary.simpleMessage("Username"),
    "rateApp": MessageLookupByLibrary.simpleMessage("Rate the app"),
    "refund_cancellation_policy": MessageLookupByLibrary.simpleMessage(
      "Refund & Cancellation Policy",
    ),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend code."),
    "roleDelegate": MessageLookupByLibrary.simpleMessage("Delegate"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "searchNotifications": MessageLookupByLibrary.simpleMessage(
      "Search notifications",
    ),
    "search_hint": MessageLookupByLibrary.simpleMessage(
      "Search for what’s on your mind…",
    ),
    "security_and_privacy": MessageLookupByLibrary.simpleMessage(
      "Security and Privacy",
    ),
    "service_example": m9,
    "service_inside_out": MessageLookupByLibrary.simpleMessage(
      "Exterior & Interior Wash",
    ),
    "service_label": MessageLookupByLibrary.simpleMessage("Service"),
    "service_title": MessageLookupByLibrary.simpleMessage("Exterior Wash"),
    "service_type": MessageLookupByLibrary.simpleMessage("Type of Service"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Share with friends",
    ),
    "startService": MessageLookupByLibrary.simpleMessage("start service"),
    "status_availableNow": MessageLookupByLibrary.simpleMessage(
      "Available now",
    ),
    "status_in_progress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "status_label": MessageLookupByLibrary.simpleMessage("Status"),
    "status_unavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
    "step_arrival": MessageLookupByLibrary.simpleMessage("Arrival to location"),
    "step_checkCar": MessageLookupByLibrary.simpleMessage("Check the car"),
    "step_drying": MessageLookupByLibrary.simpleMessage("Drying"),
    "step_finishService": MessageLookupByLibrary.simpleMessage(
      "Finish service",
    ),
    "step_startWashing": MessageLookupByLibrary.simpleMessage("Start washing"),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "terms_conditions": MessageLookupByLibrary.simpleMessage(
      "Terms & Conditions",
    ),
    "threeHours": MessageLookupByLibrary.simpleMessage("3 hours"),
    "timeRange": m10,
    "timeYesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "time_label": MessageLookupByLibrary.simpleMessage("Time"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "today_earnings": MessageLookupByLibrary.simpleMessage("Today\'s earnings"),
    "today_orders": MessageLookupByLibrary.simpleMessage("Today\'s Orders"),
    "today_profit": MessageLookupByLibrary.simpleMessage("Today\'s Profit"),
    "tryMobileWashComfort": MessageLookupByLibrary.simpleMessage(
      "Experience the comfort of mobile washing",
    ),
    "twoDaysAgo": MessageLookupByLibrary.simpleMessage("Two days ago"),
    "twoHours": MessageLookupByLibrary.simpleMessage("2 hours"),
    "unavailableForLabel": MessageLookupByLibrary.simpleMessage(
      "Unavailable for",
    ),
    "unread": MessageLookupByLibrary.simpleMessage("Unread"),
    "user_agreement": MessageLookupByLibrary.simpleMessage("User Agreement"),
    "view": MessageLookupByLibrary.simpleMessage("View"),
    "wallet": MessageLookupByLibrary.simpleMessage("Your Wallet"),
    "washes_count": MessageLookupByLibrary.simpleMessage("Washes"),
    "writeMessage": MessageLookupByLibrary.simpleMessage("Write Message..."),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "you_got_this": MessageLookupByLibrary.simpleMessage(
      "You\'re doing great! 💪",
    ),
  };
}
