// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `0000...`
  String get phoneNumberHint {
    return Intl.message(
      '0000...',
      name: 'phoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Get Verification Code`
  String get getVerificationCode {
    return Intl.message(
      'Get Verification Code',
      name: 'getVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get loginTitle {
    return Intl.message(
      'Log In',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Resend code.`
  String get resendCode {
    return Intl.message(
      'Resend code.',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code`
  String get enterCode {
    return Intl.message(
      'Enter the code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive the code? `
  String get didNotReceiveCode {
    return Intl.message(
      'Didn’t receive the code? ',
      name: 'didNotReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name...`
  String get enterYourName {
    return Intl.message(
      'Enter your name...',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Login as Guest`
  String get browseAsGuest {
    return Intl.message(
      'Login as Guest',
      name: 'browseAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Kod Ghaseel`
  String get appName {
    return Intl.message(
      'Kod Ghaseel',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `A mobile car wash service that comes to you, provided by a qualified and equipped team.`
  String get onboardingDescription {
    return Intl.message(
      'A mobile car wash service that comes to you, provided by a qualified and equipped team.',
      name: 'onboardingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Security and Privacy`
  String get security_and_privacy {
    return Intl.message(
      'Security and Privacy',
      name: 'security_and_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search notifications`
  String get searchNotifications {
    return Intl.message(
      'Search notifications',
      name: 'searchNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Two days ago`
  String get twoDaysAgo {
    return Intl.message(
      'Two days ago',
      name: 'twoDaysAgo',
      desc: '',
      args: [],
    );
  }

  /// `{count} days ago`
  String daysAgo(Object count) {
    return Intl.message(
      '$count days ago',
      name: 'daysAgo',
      desc: '',
      args: [count],
    );
  }

  /// `Experience the comfort of mobile washing`
  String get tryMobileWashComfort {
    return Intl.message(
      'Experience the comfort of mobile washing',
      name: 'tryMobileWashComfort',
      desc: '',
      args: [],
    );
  }

  /// `Be the first to know about offers and new services... Enable notifications and stay ready!`
  String get enableNotificationDescription {
    return Intl.message(
      'Be the first to know about offers and new services... Enable notifications and stay ready!',
      name: 'enableNotificationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Exclusive discounts for you`
  String get exclusiveDiscounts {
    return Intl.message(
      'Exclusive discounts for you',
      name: 'exclusiveDiscounts',
      desc: '',
      args: [],
    );
  }

  /// `Quick offers and alerts you won’t miss`
  String get fastOffersAndAlerts {
    return Intl.message(
      'Quick offers and alerts you won’t miss',
      name: 'fastOffersAndAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Tips and tricks to keep your car clean`
  String get carTipsAndSolutions {
    return Intl.message(
      'Tips and tricks to keep your car clean',
      name: 'carTipsAndSolutions',
      desc: '',
      args: [],
    );
  }

  /// `Enable Notifications`
  String get enableNotifications {
    return Intl.message(
      'Enable Notifications',
      name: 'enableNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Filter orders`
  String get filter_title {
    return Intl.message(
      'Filter orders',
      name: 'filter_title',
      desc: '',
      args: [],
    );
  }

  /// `Apply filter`
  String get filter_apply {
    return Intl.message(
      'Apply filter',
      name: 'filter_apply',
      desc: '',
      args: [],
    );
  }

  /// `Orders from 9 to 12`
  String get filter_opt_9_12 {
    return Intl.message(
      'Orders from 9 to 12',
      name: 'filter_opt_9_12',
      desc: '',
      args: [],
    );
  }

  /// `Orders from 12 to 3`
  String get filter_opt_12_3 {
    return Intl.message(
      'Orders from 12 to 3',
      name: 'filter_opt_12_3',
      desc: '',
      args: [],
    );
  }

  /// `Orders from 3 to 6`
  String get filter_opt_3_6 {
    return Intl.message(
      'Orders from 3 to 6',
      name: 'filter_opt_3_6',
      desc: '',
      args: [],
    );
  }

  /// `Orders from 6 to 9`
  String get filter_opt_6_9 {
    return Intl.message(
      'Orders from 6 to 9',
      name: 'filter_opt_6_9',
      desc: '',
      args: [],
    );
  }

  /// `Acceptance rate`
  String get acceptance_rate_title {
    return Intl.message(
      'Acceptance rate',
      name: 'acceptance_rate_title',
      desc: '',
      args: [],
    );
  }

  /// `Excellent`
  String get acceptance_rate_excellent {
    return Intl.message(
      'Excellent',
      name: 'acceptance_rate_excellent',
      desc: '',
      args: [],
    );
  }

  /// `Available now`
  String get status_availableNow {
    return Intl.message(
      'Available now',
      name: 'status_availableNow',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get status_unavailable {
    return Intl.message(
      'Unavailable',
      name: 'status_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Today's earnings`
  String get today_earnings {
    return Intl.message(
      'Today\'s earnings',
      name: 'today_earnings',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{No completed orders} =1{1 order completed} other{{count} orders completed}}`
  String completed_orders(num count) {
    return Intl.plural(
      count,
      zero: 'No completed orders',
      one: '1 order completed',
      other: '$count orders completed',
      name: 'completed_orders',
      desc: 'Pluralized completed orders label',
      args: [count],
    );
  }

  /// `Number of orders so far`
  String get orders_so_far_title {
    return Intl.message(
      'Number of orders so far',
      name: 'orders_so_far_title',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{orders} =1{order} other{orders}}`
  String orders_count(num count) {
    return Intl.plural(
      count,
      zero: 'orders',
      one: 'order',
      other: 'orders',
      name: 'orders_count',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0{daily orders} =1{daily order} other{daily orders}}`
  String daily_orders(num count) {
    return Intl.plural(
      count,
      zero: 'daily orders',
      one: 'daily order',
      other: 'daily orders',
      name: 'daily_orders',
      desc: '',
      args: [count],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable for`
  String get unavailableForLabel {
    return Intl.message(
      'Unavailable for',
      name: 'unavailableForLabel',
      desc: '',
      args: [],
    );
  }

  /// `1 hour`
  String get oneHour {
    return Intl.message(
      '1 hour',
      name: 'oneHour',
      desc: '',
      args: [],
    );
  }

  /// `2 hours`
  String get twoHours {
    return Intl.message(
      '2 hours',
      name: 'twoHours',
      desc: '',
      args: [],
    );
  }

  /// `3 hours`
  String get threeHours {
    return Intl.message(
      '3 hours',
      name: 'threeHours',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Enter minutes`
  String get enterMinutesHint {
    return Intl.message(
      'Enter minutes',
      name: 'enterMinutesHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter hours`
  String get enterHoursHint {
    return Intl.message(
      'Enter hours',
      name: 'enterHoursHint',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number of minutes`
  String get invalidMinutesMsg {
    return Intl.message(
      'Please enter a valid number of minutes',
      name: 'invalidMinutesMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number of hours`
  String get invalidHoursMsg {
    return Intl.message(
      'Please enter a valid number of hours',
      name: 'invalidHoursMsg',
      desc: '',
      args: [],
    );
  }

  /// `Hello {name}`
  String helloName(String name) {
    return Intl.message(
      'Hello $name',
      name: 'helloName',
      desc: 'Greeting with name',
      args: [name],
    );
  }

  /// `Delegate`
  String get roleDelegate {
    return Intl.message(
      'Delegate',
      name: 'roleDelegate',
      desc: '',
      args: [],
    );
  }

  /// `Availability auto-enabled`
  String get autoEnabledSnackbar {
    return Intl.message(
      'Availability auto-enabled',
      name: 'autoEnabledSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `You can’t enable yet. {minutes}m {seconds}s left`
  String cannotEnableYet(int minutes, int seconds) {
    return Intl.message(
      'You can’t enable yet. ${minutes}m ${seconds}s left',
      name: 'cannotEnableYet',
      desc: 'Shown when trying to enable before cooldown ends',
      args: [minutes, seconds],
    );
  }

  /// `Order No.`
  String get order_number {
    return Intl.message(
      'Order No.',
      name: 'order_number',
      desc: '',
      args: [],
    );
  }

  /// `Package`
  String get package {
    return Intl.message(
      'Package',
      name: 'package',
      desc: '',
      args: [],
    );
  }

  /// `Washes`
  String get washes_count {
    return Intl.message(
      'Washes',
      name: 'washes_count',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date_label {
    return Intl.message(
      'Date',
      name: 'date_label',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time_label {
    return Intl.message(
      'Time',
      name: 'time_label',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service_label {
    return Intl.message(
      'Service',
      name: 'service_label',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status_label {
    return Intl.message(
      'Status',
      name: 'status_label',
      desc: '',
      args: [],
    );
  }

  /// `Silver`
  String get package_silver {
    return Intl.message(
      'Silver',
      name: 'package_silver',
      desc: '',
      args: [],
    );
  }

  /// `Exterior & Interior Wash`
  String get service_inside_out {
    return Intl.message(
      'Exterior & Interior Wash',
      name: 'service_inside_out',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get status_in_progress {
    return Intl.message(
      'In Progress',
      name: 'status_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get status_completed {
    return Intl.message(
      'Completed',
      name: 'status_completed',
      desc: '',
      args: [],
    );
  }

  /// `Assigned`
  String get status_assigned {
    return Intl.message(
      'Assigned',
      name: 'status_assigned',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get status_pending {
    return Intl.message(
      'Pending',
      name: 'status_pending',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get status_cancelled {
    return Intl.message(
      'Cancelled',
      name: 'status_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Undefined Service`
  String get service_undefined {
    return Intl.message(
      'Undefined Service',
      name: 'service_undefined',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders_title {
    return Intl.message(
      'Orders',
      name: 'orders_title',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get orders_upcoming {
    return Intl.message(
      'Upcoming',
      name: 'orders_upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get orders_current {
    return Intl.message(
      'Current',
      name: 'orders_current',
      desc: '',
      args: [],
    );
  }

  /// `Past`
  String get orders_past {
    return Intl.message(
      'Past',
      name: 'orders_past',
      desc: '',
      args: [],
    );
  }

  /// `No orders`
  String get no_orders {
    return Intl.message(
      'No orders',
      name: 'no_orders',
      desc: '',
      args: [],
    );
  }

  /// `Frequently Asked Questions`
  String get faq_title {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'faq_title',
      desc: '',
      args: [],
    );
  }

  /// `Search for what’s on your mind…`
  String get faq_search_hint {
    return Intl.message(
      'Search for what’s on your mind…',
      name: 'faq_search_hint',
      desc: '',
      args: [],
    );
  }

  /// `How long does it take you to arrive?`
  String get faq_q_how_long_arrive {
    return Intl.message(
      'How long does it take you to arrive?',
      name: 'faq_q_how_long_arrive',
      desc: '',
      args: [],
    );
  }

  /// `Quick booking: 15–30 minutes`
  String get faq_a_quick_booking_time {
    return Intl.message(
      'Quick booking: 15–30 minutes',
      name: 'faq_a_quick_booking_time',
      desc: '',
      args: [],
    );
  }

  /// `What payment methods are available?`
  String get faq_q_payment_methods {
    return Intl.message(
      'What payment methods are available?',
      name: 'faq_q_payment_methods',
      desc: '',
      args: [],
    );
  }

  /// `Credit & debit cards (Visa, Mastercard)`
  String get faq_a_payment_methods_list {
    return Intl.message(
      'Credit & debit cards (Visa, Mastercard)',
      name: 'faq_a_payment_methods_list',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled booking: according to your selected time`
  String get faq_bullet_scheduled {
    return Intl.message(
      'Scheduled booking: according to your selected time',
      name: 'faq_bullet_scheduled',
      desc: '',
      args: [],
    );
  }

  /// `Peak times: it may take up to 45 minutes`
  String get faq_bullet_peak {
    return Intl.message(
      'Peak times: it may take up to 45 minutes',
      name: 'faq_bullet_peak',
      desc: '',
      args: [],
    );
  }

  /// `Did this solve your issue?`
  String get faq_did_this_help {
    return Intl.message(
      'Did this solve your issue?',
      name: 'faq_did_this_help',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications_title {
    return Intl.message(
      'Notifications',
      name: 'notifications_title',
      desc: '',
      args: [],
    );
  }

  /// `Payment notifications`
  String get notifications_payment {
    return Intl.message(
      'Payment notifications',
      name: 'notifications_payment',
      desc: '',
      args: [],
    );
  }

  /// `Message notifications`
  String get notifications_messages {
    return Intl.message(
      'Message notifications',
      name: 'notifications_messages',
      desc: '',
      args: [],
    );
  }

  /// `Reminder notifications`
  String get notifications_reminders {
    return Intl.message(
      'Reminder notifications',
      name: 'notifications_reminders',
      desc: '',
      args: [],
    );
  }

  /// `Offer notifications`
  String get notifications_offers {
    return Intl.message(
      'Offer notifications',
      name: 'notifications_offers',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy_title {
    return Intl.message(
      'Privacy',
      name: 'privacy_title',
      desc: '',
      args: [],
    );
  }

  /// `Search for what’s on your mind…`
  String get search_hint {
    return Intl.message(
      'Search for what’s on your mind…',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Refund & Cancellation Policy`
  String get refund_cancellation_policy {
    return Intl.message(
      'Refund & Cancellation Policy',
      name: 'refund_cancellation_policy',
      desc: '',
      args: [],
    );
  }

  /// `Cookies Policy`
  String get cookies_policy {
    return Intl.message(
      'Cookies Policy',
      name: 'cookies_policy',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get user_agreement {
    return Intl.message(
      'User Agreement',
      name: 'user_agreement',
      desc: '',
      args: [],
    );
  }

  /// `Add personal email`
  String get add_personal_email {
    return Intl.message(
      'Add personal email',
      name: 'add_personal_email',
      desc: '',
      args: [],
    );
  }

  /// `Sara Mohamed`
  String get profile_name_sample {
    return Intl.message(
      'Sara Mohamed',
      name: 'profile_name_sample',
      desc: '',
      args: [],
    );
  }

  /// `Gold plan`
  String get gold_plan {
    return Intl.message(
      'Gold plan',
      name: 'gold_plan',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Your Wallet`
  String get wallet {
    return Intl.message(
      'Your Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Packages`
  String get packages {
    return Intl.message(
      'Packages',
      name: 'packages',
      desc: '',
      args: [],
    );
  }

  /// `Log out!`
  String get logoutTitle {
    return Intl.message(
      'Log out!',
      name: 'logoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Yes, sure!`
  String get logoutConfirm {
    return Intl.message(
      'Yes, sure!',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Rate the app`
  String get rateApp {
    return Intl.message(
      'Rate the app',
      name: 'rateApp',
      desc: '',
      args: [],
    );
  }

  /// `Share with friends`
  String get shareWithFriends {
    return Intl.message(
      'Share with friends',
      name: 'shareWithFriends',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get profile_title {
    return Intl.message(
      'My profile',
      name: 'profile_title',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get profile_username {
    return Intl.message(
      'Username',
      name: 'profile_username',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get profile_email {
    return Intl.message(
      'Email address',
      name: 'profile_email',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get profile_phone {
    return Intl.message(
      'Phone number',
      name: 'profile_phone',
      desc: '',
      args: [],
    );
  }

  /// `Acceptance rate`
  String get acceptance_rate {
    return Intl.message(
      'Acceptance rate',
      name: 'acceptance_rate',
      desc: '',
      args: [],
    );
  }

  /// `Order progress`
  String get orderProgressTitle {
    return Intl.message(
      'Order progress',
      name: 'orderProgressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Finish service`
  String get finishService {
    return Intl.message(
      'Finish service',
      name: 'finishService',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get pauseTemporarily {
    return Intl.message(
      'Pause',
      name: 'pauseTemporarily',
      desc: '',
      args: [],
    );
  }

  /// `Today's Profit`
  String get today_profit {
    return Intl.message(
      'Today\'s Profit',
      name: 'today_profit',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Profit`
  String get monthly_profit {
    return Intl.message(
      'Monthly Profit',
      name: 'monthly_profit',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get currency_sar {
    return Intl.message(
      'SAR',
      name: 'currency_sar',
      desc: '',
      args: [],
    );
  }

  /// `From {count} orders`
  String from_orders(Object count) {
    return Intl.message(
      'From $count orders',
      name: 'from_orders',
      desc: '',
      args: [count],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Average Order`
  String get avg_order {
    return Intl.message(
      'Average Order',
      name: 'avg_order',
      desc: '',
      args: [],
    );
  }

  /// `Last Earnings`
  String get last_earnings {
    return Intl.message(
      'Last Earnings',
      name: 'last_earnings',
      desc: '',
      args: [],
    );
  }

  /// `Today's Orders`
  String get today_orders {
    return Intl.message(
      'Today\'s Orders',
      name: 'today_orders',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Orders`
  String get monthly_orders {
    return Intl.message(
      'Monthly Orders',
      name: 'monthly_orders',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Keep it up!`
  String get keep_it_up {
    return Intl.message(
      'Keep it up!',
      name: 'keep_it_up',
      desc: '',
      args: [],
    );
  }

  /// `You're doing great! 💪`
  String get you_got_this {
    return Intl.message(
      'You\'re doing great! 💪',
      name: 'you_got_this',
      desc: '',
      args: [],
    );
  }

  /// `{service} - {time}`
  String service_example(Object service, Object time) {
    return Intl.message(
      '$service - $time',
      name: 'service_example',
      desc: '',
      args: [service, time],
    );
  }

  /// `Mark as read`
  String get mark_as_read {
    return Intl.message(
      'Mark as read',
      name: 'mark_as_read',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Unread`
  String get unread {
    return Intl.message(
      'Unread',
      name: 'unread',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filter`
  String get apply_filter {
    return Intl.message(
      'Apply Filter',
      name: 'apply_filter',
      desc: '',
      args: [],
    );
  }

  /// `King Fahd Street, Riyadh`
  String get mapAddress {
    return Intl.message(
      'King Fahd Street, Riyadh',
      name: 'mapAddress',
      desc: '',
      args: [],
    );
  }

  /// `start service`
  String get startService {
    return Intl.message(
      'start service',
      name: 'startService',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get client {
    return Intl.message(
      'Client',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Day and Time`
  String get day_and_time {
    return Intl.message(
      'Day and Time',
      name: 'day_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Thursday, August 10`
  String get day_time_for_service {
    return Intl.message(
      'Thursday, August 10',
      name: 'day_time_for_service',
      desc: '',
      args: [],
    );
  }

  /// `Type of Service`
  String get service_type {
    return Intl.message(
      'Type of Service',
      name: 'service_type',
      desc: '',
      args: [],
    );
  }

  /// `Exterior Wash`
  String get service_title {
    return Intl.message(
      'Exterior Wash',
      name: 'service_title',
      desc: '',
      args: [],
    );
  }

  /// `Toyota Camry 2022 - White - A B J 123`
  String get car_data {
    return Intl.message(
      'Toyota Camry 2022 - White - A B J 123',
      name: 'car_data',
      desc: '',
      args: [],
    );
  }

  /// `Arrival to location`
  String get step_arrival {
    return Intl.message(
      'Arrival to location',
      name: 'step_arrival',
      desc: '',
      args: [],
    );
  }

  /// `Check the car`
  String get step_checkCar {
    return Intl.message(
      'Check the car',
      name: 'step_checkCar',
      desc: '',
      args: [],
    );
  }

  /// `Start washing`
  String get step_startWashing {
    return Intl.message(
      'Start washing',
      name: 'step_startWashing',
      desc: '',
      args: [],
    );
  }

  /// `Drying`
  String get step_drying {
    return Intl.message(
      'Drying',
      name: 'step_drying',
      desc: '',
      args: [],
    );
  }

  /// `Finish service`
  String get step_finishService {
    return Intl.message(
      'Finish service',
      name: 'step_finishService',
      desc: '',
      args: [],
    );
  }

  /// `{from} - {to}`
  String timeRange(String from, String to) {
    return Intl.message(
      '$from - $to',
      name: 'timeRange',
      desc: 'Time range shown under the step',
      args: [from, to],
    );
  }

  /// `{count} min`
  String nMinutes(int count) {
    return Intl.message(
      '$count min',
      name: 'nMinutes',
      desc: 'Short minutes label',
      args: [count],
    );
  }

  /// `{count} min to finish`
  String nMinutesToFinish(int count) {
    return Intl.message(
      '$count min to finish',
      name: 'nMinutesToFinish',
      desc: 'Minutes remaining to finish',
      args: [count],
    );
  }

  /// `current order`
  String get currentOrder {
    return Intl.message(
      'current order',
      name: 'currentOrder',
      desc: '',
      args: [],
    );
  }

  /// `previous orders`
  String get previousOrders {
    return Intl.message(
      'previous orders',
      name: 'previousOrders',
      desc: '',
      args: [],
    );
  }

  /// `Toyota Camry - full wash - 2.5 km`
  String get carServiceDescription {
    return Intl.message(
      'Toyota Camry - full wash - 2.5 km',
      name: 'carServiceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your car wash has started! 🚗`
  String get notification1Title {
    return Intl.message(
      'Your car wash has started! 🚗',
      name: 'notification1Title',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy shopping while we clean it.`
  String get notification1Subtitle {
    return Intl.message(
      'Enjoy shopping while we clean it.',
      name: 'notification1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your car is sparkling clean! ✨`
  String get notification2Title {
    return Intl.message(
      'Your car is sparkling clean! ✨',
      name: 'notification2Title',
      desc: '',
      args: [],
    );
  }

  /// `The wash is complete successfully.`
  String get notification2Subtitle {
    return Intl.message(
      'The wash is complete successfully.',
      name: 'notification2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your car has been delivered! 🌺`
  String get notification3Title {
    return Intl.message(
      'Your car has been delivered! 🌺',
      name: 'notification3Title',
      desc: '',
      args: [],
    );
  }

  /// `Book your next wash now.`
  String get notification3Subtitle {
    return Intl.message(
      'Book your next wash now.',
      name: 'notification3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your order is being processed 🧽`
  String get notification4Title {
    return Intl.message(
      'Your order is being processed 🧽',
      name: 'notification4Title',
      desc: '',
      args: [],
    );
  }

  /// `Our driver is on the way to pick up the car.`
  String get notification4Subtitle {
    return Intl.message(
      'Our driver is on the way to pick up the car.',
      name: 'notification4Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription is active! 🧼`
  String get notification5Title {
    return Intl.message(
      'Your subscription is active! 🧼',
      name: 'notification5Title',
      desc: '',
      args: [],
    );
  }

  /// `Press back again to exit the app.`
  String get pressBackAgainToExit {
    return Intl.message(
      'Press back again to exit the app.',
      name: 'pressBackAgainToExit',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Washing Code`
  String get welcomeKodGhaseel {
    return Intl.message(
      'Welcome to Washing Code',
      name: 'welcomeKodGhaseel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number to log in`
  String get enterPhoneToLogin {
    return Intl.message(
      'Enter your phone number to log in',
      name: 'enterPhoneToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Your car will be washed regularly.`
  String get notification5Subtitle {
    return Intl.message(
      'Your car will be washed regularly.',
      name: 'notification5Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get timeYesterday {
    return Intl.message(
      'Yesterday',
      name: 'timeYesterday',
      desc: '',
      args: [],
    );
  }

  /// `Registration Required`
  String get registerRequiredTitle {
    return Intl.message(
      'Registration Required',
      name: 'registerRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `You need to register or log in to continue using this feature.`
  String get registerRequiredMessage {
    return Intl.message(
      'You need to register or log in to continue using this feature.',
      name: 'registerRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get registerNow {
    return Intl.message(
      'Register Now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `+966 1515 1511 333`
  String get userPhoneNumber {
    return Intl.message(
      '+966 1515 1511 333',
      name: 'userPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mark as read`
  String get markAsRead {
    return Intl.message(
      'Mark as read',
      name: 'markAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Write Message...`
  String get writeMessage {
    return Intl.message(
      'Write Message...',
      name: 'writeMessage',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet {
    return Intl.message(
      'No internet connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Location sharing disabled. Tap here to enable.`
  String get location_disabled {
    return Intl.message(
      'Location sharing disabled. Tap here to enable.',
      name: 'location_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Please enter your phone number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Verification code resent successfully`
  String get codeResentSuccessfully {
    return Intl.message(
      'Verification code resent successfully',
      name: 'codeResentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get invalidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message(
      'Check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Arrived at location`
  String get arrivalNotes {
    return Intl.message(
      'Arrived at location',
      name: 'arrivalNotes',
      desc: '',
      args: [],
    );
  }

  /// `Order completed successfully`
  String get orderCompletedSuccess {
    return Intl.message(
      'Order completed successfully',
      name: 'orderCompletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again`
  String get genericError {
    return Intl.message(
      'An error occurred. Please try again',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load order status. Please try again`
  String get errorLoadOrderStages {
    return Intl.message(
      'Failed to load order status. Please try again',
      name: 'errorLoadOrderStages',
      desc: '',
      args: [],
    );
  }

  /// `Failed to accept order. Please try again`
  String get errorAcceptOrder {
    return Intl.message(
      'Failed to accept order. Please try again',
      name: 'errorAcceptOrder',
      desc: '',
      args: [],
    );
  }

  /// `Failed to register arrival. Please try again`
  String get errorArrived {
    return Intl.message(
      'Failed to register arrival. Please try again',
      name: 'errorArrived',
      desc: '',
      args: [],
    );
  }

  /// `Failed to verify car. Please try again`
  String get errorCarVerified {
    return Intl.message(
      'Failed to verify car. Please try again',
      name: 'errorCarVerified',
      desc: '',
      args: [],
    );
  }

  /// `Failed to start washing process. Please try again`
  String get errorWashingStarted {
    return Intl.message(
      'Failed to start washing process. Please try again',
      name: 'errorWashingStarted',
      desc: '',
      args: [],
    );
  }

  /// `Failed to complete washing process. Please try again`
  String get errorWashingCompleted {
    return Intl.message(
      'Failed to complete washing process. Please try again',
      name: 'errorWashingCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Failed to start drying process. Please try again`
  String get errorDryingStarted {
    return Intl.message(
      'Failed to start drying process. Please try again',
      name: 'errorDryingStarted',
      desc: '',
      args: [],
    );
  }

  /// `Failed to complete drying process. Please try again`
  String get errorDryingCompleted {
    return Intl.message(
      'Failed to complete drying process. Please try again',
      name: 'errorDryingCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Failed to complete order. Please try again`
  String get errorCompleteOrder {
    return Intl.message(
      'Failed to complete order. Please try again',
      name: 'errorCompleteOrder',
      desc: '',
      args: [],
    );
  }

  /// `Your Progress`
  String get yourProgress {
    return Intl.message(
      'Your Progress',
      name: 'yourProgress',
      desc: '',
      args: [],
    );
  }

  /// `Service Progress`
  String get serviceProgress {
    return Intl.message(
      'Service Progress',
      name: 'serviceProgress',
      desc: '',
      args: [],
    );
  }

  /// `Minutes : Seconds`
  String get minutesSeconds {
    return Intl.message(
      'Minutes : Seconds',
      name: 'minutesSeconds',
      desc: '',
      args: [],
    );
  }

  /// `This order is already completed`
  String get orderAlreadyCompleted {
    return Intl.message(
      'This order is already completed',
      name: 'orderAlreadyCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Navigate`
  String get navigate {
    return Intl.message(
      'Navigate',
      name: 'navigate',
      desc: '',
      args: [],
    );
  }

  /// `Customer Location`
  String get customerLocation {
    return Intl.message(
      'Customer Location',
      name: 'customerLocation',
      desc: '',
      args: [],
    );
  }

  /// `Error opening navigation`
  String get errorOpeningNavigation {
    return Intl.message(
      'Error opening navigation',
      name: 'errorOpeningNavigation',
      desc: '',
      args: [],
    );
  }

  /// `Error calling`
  String get errorCalling {
    return Intl.message(
      'Error calling',
      name: 'errorCalling',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not available`
  String get phoneNumberNotAvailable {
    return Intl.message(
      'Phone number not available',
      name: 'phoneNumberNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Phone number changed successfully`
  String get phoneNumberChangedSuccessfully {
    return Intl.message(
      'Phone number changed successfully',
      name: 'phoneNumberChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code sent to +{phone}`
  String enterVerificationCodeSentTo(String phone) {
    return Intl.message(
      'Enter the verification code sent to +$phone',
      name: 'enterVerificationCodeSentTo',
      desc: 'Enter verification code sent to phone number',
      args: [phone],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Location Permission Required`
  String get locationPermissionRequired {
    return Intl.message(
      'Location Permission Required',
      name: 'locationPermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `This app needs access to your location at all times to track your position and provide services. Please enable 'Allow all the time' location permission.`
  String get locationPermissionDescription {
    return Intl.message(
      'This app needs access to your location at all times to track your position and provide services. Please enable \'Allow all the time\' location permission.',
      name: 'locationPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Open Location Settings`
  String get openLocationSettings {
    return Intl.message(
      'Open Location Settings',
      name: 'openLocationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Check Again`
  String get checkAgain {
    return Intl.message(
      'Check Again',
      name: 'checkAgain',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing data, please wait`
  String get analyzingDataPleaseWait {
    return Intl.message(
      'Analyzing data, please wait',
      name: 'analyzingDataPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Contact us here`
  String get needHelp {
    return Intl.message(
      'Need help? Contact us here',
      name: 'needHelp',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load contact information`
  String get unableToLoadContactInfo {
    return Intl.message(
      'Unable to load contact information',
      name: 'unableToLoadContactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get whatsapp {
    return Intl.message(
      'WhatsApp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Unable to open WhatsApp`
  String get unableToOpenWhatsApp {
    return Intl.message(
      'Unable to open WhatsApp',
      name: 'unableToOpenWhatsApp',
      desc: '',
      args: [],
    );
  }

  /// `Unable to send email`
  String get unableToSendEmail {
    return Intl.message(
      'Unable to send email',
      name: 'unableToSendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `E-mail address`
  String get emailAddress {
    return Intl.message(
      'E-mail address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressLabel {
    return Intl.message(
      'Address',
      name: 'addressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccountTitle {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Warning: This action cannot be undone`
  String get deleteAccountWarning {
    return Intl.message(
      'Warning: This action cannot be undone',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `What happens when you delete your account?`
  String get deleteAccountSectionTitle {
    return Intl.message(
      'What happens when you delete your account?',
      name: 'deleteAccountSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your profile and personal information will be permanently deleted`
  String get deleteAccountBullet1 {
    return Intl.message(
      'Your profile and personal information will be permanently deleted',
      name: 'deleteAccountBullet1',
      desc: '',
      args: [],
    );
  }

  /// `You will no longer have access to your order history`
  String get deleteAccountBullet2 {
    return Intl.message(
      'You will no longer have access to your order history',
      name: 'deleteAccountBullet2',
      desc: '',
      args: [],
    );
  }

  /// `Any currently active orders will be cancelled`
  String get deleteAccountBullet3 {
    return Intl.message(
      'Any currently active orders will be cancelled',
      name: 'deleteAccountBullet3',
      desc: '',
      args: [],
    );
  }

  /// `Your data cannot be recovered after deletion`
  String get deleteAccountBullet4 {
    return Intl.message(
      'Your data cannot be recovered after deletion',
      name: 'deleteAccountBullet4',
      desc: '',
      args: [],
    );
  }

  /// `Your location tracking will stop immediately`
  String get deleteAccountBullet5 {
    return Intl.message(
      'Your location tracking will stop immediately',
      name: 'deleteAccountBullet5',
      desc: '',
      args: [],
    );
  }

  /// `Note: Some financial or legal data may be retained for a limited period in accordance with our privacy policy and legal requirements.`
  String get deleteAccountRetentionNotice {
    return Intl.message(
      'Note: Some financial or legal data may be retained for a limited period in accordance with our privacy policy and legal requirements.',
      name: 'deleteAccountRetentionNotice',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Account Deletion`
  String get deleteAccountConfirmTitle {
    return Intl.message(
      'Confirm Account Deletion',
      name: 'deleteAccountConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you absolutely sure?\n\nThis action cannot be undone. All your data will be permanently deleted.`
  String get deleteAccountConfirmMessage {
    return Intl.message(
      'Are you absolutely sure?\n\nThis action cannot be undone. All your data will be permanently deleted.',
      name: 'deleteAccountConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes, delete my account`
  String get deleteAccountConfirmButton {
    return Intl.message(
      'Yes, delete my account',
      name: 'deleteAccountConfirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Permanently delete my account`
  String get deleteAccountButton {
    return Intl.message(
      'Permanently delete my account',
      name: 'deleteAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Account deletion failed. Please contact support.`
  String get deleteAccountFallbackError {
    return Intl.message(
      'Account deletion failed. Please contact support.',
      name: 'deleteAccountFallbackError',
      desc: '',
      args: [],
    );
  }

  /// `Session not found. Please log in again.`
  String get deleteAccountSessionError {
    return Intl.message(
      'Session not found. Please log in again.',
      name: 'deleteAccountSessionError',
      desc: '',
      args: [],
    );
  }

  /// `Location Access Required`
  String get locationPermissionDialogTitle {
    return Intl.message(
      'Location Access Required',
      name: 'locationPermissionDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Washing Code Provider uses your location to:\n\n• Show customers your real-time position while on a job\n• Automatically assign nearby service requests to you\n• Confirm pickup and delivery locations\n\nYour location is only shared with customers during an active service session.`
  String get locationPermissionDialogBody {
    return Intl.message(
      'Washing Code Provider uses your location to:\n\n• Show customers your real-time position while on a job\n• Automatically assign nearby service requests to you\n• Confirm pickup and delivery locations\n\nYour location is only shared with customers during an active service session.',
      name: 'locationPermissionDialogBody',
      desc: '',
      args: [],
    );
  }

  /// `Not Now`
  String get locationPermissionNotNow {
    return Intl.message(
      'Not Now',
      name: 'locationPermissionNotNow',
      desc: '',
      args: [],
    );
  }

  /// `Allow Location`
  String get locationPermissionAllow {
    return Intl.message(
      'Allow Location',
      name: 'locationPermissionAllow',
      desc: '',
      args: [],
    );
  }

  /// `Background Location for Active Jobs`
  String get backgroundLocationDialogTitle {
    return Intl.message(
      'Background Location for Active Jobs',
      name: 'backgroundLocationDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `To let customers track your arrival on a live map during a service job, the app needs to access your location even when you switch to other apps.\n\nThis is only active during an assigned job and stops automatically when the job is completed.`
  String get backgroundLocationDialogBody {
    return Intl.message(
      'To let customers track your arrival on a live map during a service job, the app needs to access your location even when you switch to other apps.\n\nThis is only active during an assigned job and stops automatically when the job is completed.',
      name: 'backgroundLocationDialogBody',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get backgroundLocationSkip {
    return Intl.message(
      'Skip',
      name: 'backgroundLocationSkip',
      desc: '',
      args: [],
    );
  }

  /// `Allow Always`
  String get backgroundLocationAllow {
    return Intl.message(
      'Allow Always',
      name: 'backgroundLocationAllow',
      desc: '',
      args: [],
    );
  }

  /// `Unable to make phone call`
  String get unableToMakePhoneCall {
    return Intl.message(
      'Unable to make phone call',
      name: 'unableToMakePhoneCall',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
