// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(minutes, seconds) =>
      "لا يمكنك التفعيل الآن. متبقي ${minutes}د ${seconds}ث";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'لا يوجد طلبات مكتملة', one: 'طلب واحد مكتمل', other: '${count} طلب مكتمل')}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'طلبات يومياً', one: 'طلب يومياً', other: 'طلبات يومياً')}";

  static String m3(count) => "${count} أيام مضت";

  static String m4(phone) => "ادخل رمز التحقيق المرسل على +${phone}";

  static String m5(count) => "من ${count} طلبات";

  static String m6(name) => "مرحباً ${name} ";

  static String m7(count) => "${count} دقائق";

  static String m8(count) => "${count} دقائق حتى الانتهاء";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'طلبات', one: 'طلب', other: 'طلبات')}";

  static String m10(service, time) => "${service} - ${time}";

  static String m11(from, to) => "${from} - ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("من نحن؟"),
        "acceptance_rate": MessageLookupByLibrary.simpleMessage("معدل القبول"),
        "acceptance_rate_excellent":
            MessageLookupByLibrary.simpleMessage("ممتاز"),
        "acceptance_rate_title":
            MessageLookupByLibrary.simpleMessage("معدل القبول"),
        "add_personal_email":
            MessageLookupByLibrary.simpleMessage("اضف ايميل شخصي"),
        "addressLabel": MessageLookupByLibrary.simpleMessage("العنوان"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("لديك حساب بالفعل؟"),
        "analyzingDataPleaseWait": MessageLookupByLibrary.simpleMessage(
            "جاري تحليل البيانات برجاء الانتظار"),
        "appName": MessageLookupByLibrary.simpleMessage("كود غسيل"),
        "apply_filter": MessageLookupByLibrary.simpleMessage("تطبيق الفلتر"),
        "arrivalNotes": MessageLookupByLibrary.simpleMessage("وصلت للموقع"),
        "autoEnabledSnackbar":
            MessageLookupByLibrary.simpleMessage("تم تفعيل التوفر تلقائياً"),
        "avg_order": MessageLookupByLibrary.simpleMessage("متوسط الطلب"),
        "browseAsGuest": MessageLookupByLibrary.simpleMessage("تصفح كزائر"),
        "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "cannotEnableYet": m0,
        "carServiceDescription": MessageLookupByLibrary.simpleMessage(
            "تويتا كامري - غسيل كامل - 2.5 كم"),
        "carTipsAndSolutions": MessageLookupByLibrary.simpleMessage(
            "نصائح وحلول للحفاظ على سيارتك نظيفة"),
        "car_data": MessageLookupByLibrary.simpleMessage(
            "تويوتا كامري 2022 - أبيض - أ ب ج 123"),
        "change_language": MessageLookupByLibrary.simpleMessage("تغيير اللغة"),
        "check": MessageLookupByLibrary.simpleMessage("تحقق"),
        "checkAgain": MessageLookupByLibrary.simpleMessage("التحقق مرة أخرى"),
        "client": MessageLookupByLibrary.simpleMessage("عميل"),
        "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
        "codeResentSuccessfully": MessageLookupByLibrary.simpleMessage(
            "تم إعادة إرسال رمز التحقق بنجاح"),
        "completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
        "completed_orders": m1,
        "cookies_policy":
            MessageLookupByLibrary.simpleMessage("سياسة ملفات الارتباط"),
        "currency_sar": MessageLookupByLibrary.simpleMessage("ريال"),
        "currentOrder": MessageLookupByLibrary.simpleMessage("الطلب الحالي"),
        "customerLocation": MessageLookupByLibrary.simpleMessage("موقع العميل"),
        "daily": MessageLookupByLibrary.simpleMessage("يومي"),
        "daily_orders": m2,
        "date": MessageLookupByLibrary.simpleMessage("التاريخ"),
        "date_label": MessageLookupByLibrary.simpleMessage("التاريخ"),
        "day_and_time": MessageLookupByLibrary.simpleMessage("الوقت و اليوم"),
        "day_time_for_service":
            MessageLookupByLibrary.simpleMessage("الخميس 10 اغسطس"),
        "daysAgo": m3,
        "delete": MessageLookupByLibrary.simpleMessage("حذف"),
        "didNotReceiveCode":
            MessageLookupByLibrary.simpleMessage("لم تصلك الرسالة؟ "),
        "done": MessageLookupByLibrary.simpleMessage("تم"),
        "emailAddress":
            MessageLookupByLibrary.simpleMessage("البريد الالكتروني"),
        "enableNotificationDescription": MessageLookupByLibrary.simpleMessage(
            "خليك دايمًا أول من يعرف بالعروض والخدمات الجديدة... فعِّل الإشعارات وخليك مستعد!"),
        "enableNotifications":
            MessageLookupByLibrary.simpleMessage("فعِّل الإشعارات"),
        "enterCode": MessageLookupByLibrary.simpleMessage("أدخل الرمز"),
        "enterHoursHint":
            MessageLookupByLibrary.simpleMessage("اكتب عدد الساعات"),
        "enterMinutesHint":
            MessageLookupByLibrary.simpleMessage("اكتب عدد الدقائق"),
        "enterPhoneToLogin": MessageLookupByLibrary.simpleMessage(
            "أدخل رقم هاتفك لتسجيل الدخول"),
        "enterVerificationCodeSentTo": m4,
        "enterYourName": MessageLookupByLibrary.simpleMessage("ادخل اسمك.."),
        "enterYourPhoneNumber":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال رقم الهاتف"),
        "errorAcceptOrder": MessageLookupByLibrary.simpleMessage(
            "فشل في قبول الطلب. يرجى المحاولة مرة أخرى"),
        "errorArrived": MessageLookupByLibrary.simpleMessage(
            "فشل في تسجيل الوصول. يرجى المحاولة مرة أخرى"),
        "errorCalling": MessageLookupByLibrary.simpleMessage("خطأ في الاتصال"),
        "errorCarVerified": MessageLookupByLibrary.simpleMessage(
            "فشل في التحقق من السيارة. يرجى المحاولة مرة أخرى"),
        "errorCompleteOrder": MessageLookupByLibrary.simpleMessage(
            "فشل في إنهاء الطلب. يرجى المحاولة مرة أخرى"),
        "errorDryingCompleted": MessageLookupByLibrary.simpleMessage(
            "فشل في إتمام عملية التجفيف. يرجى المحاولة مرة أخرى"),
        "errorDryingStarted": MessageLookupByLibrary.simpleMessage(
            "فشل في بدء عملية التجفيف. يرجى المحاولة مرة أخرى"),
        "errorLoadOrderStages": MessageLookupByLibrary.simpleMessage(
            "فشل في تحميل حالة الطلب. يرجى المحاولة مرة أخرى"),
        "errorOpeningNavigation":
            MessageLookupByLibrary.simpleMessage("خطأ في فتح التنقل"),
        "errorWashingCompleted": MessageLookupByLibrary.simpleMessage(
            "فشل في إتمام عملية الغسيل. يرجى المحاولة مرة أخرى"),
        "errorWashingStarted": MessageLookupByLibrary.simpleMessage(
            "فشل في بدء عملية الغسيل. يرجى المحاولة مرة أخرى"),
        "exclusiveDiscounts":
            MessageLookupByLibrary.simpleMessage("خصومات حصرية لك"),
        "faq_a_payment_methods_list": MessageLookupByLibrary.simpleMessage(
            "بطاقات الائتمان والخصم (فيزا، ماستركارد)"),
        "faq_a_quick_booking_time":
            MessageLookupByLibrary.simpleMessage("الحجز السريع: 15–30 دقيقة"),
        "faq_bullet_peak": MessageLookupByLibrary.simpleMessage(
            "أوقات الذروة: قد تستغرق حتى 45 دقيقة"),
        "faq_bullet_scheduled": MessageLookupByLibrary.simpleMessage(
            "الحجز المجدول: حسب الموعد المختار"),
        "faq_did_this_help":
            MessageLookupByLibrary.simpleMessage("هل ساعدك ذلك في حل مشكلتك؟"),
        "faq_q_how_long_arrive":
            MessageLookupByLibrary.simpleMessage("كم من الوقت تحتاجون للوصول؟"),
        "faq_q_payment_methods":
            MessageLookupByLibrary.simpleMessage("ما هي طرق الدفع المتاحة؟"),
        "faq_search_hint":
            MessageLookupByLibrary.simpleMessage("ابحث عمّا يدور ببالك…"),
        "faq_title": MessageLookupByLibrary.simpleMessage("الأسئلة الشائعة"),
        "fastOffersAndAlerts": MessageLookupByLibrary.simpleMessage(
            "عروض وتنبيهات سريعة ما تفوتك"),
        "fieldRequired":
            MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب"),
        "filter": MessageLookupByLibrary.simpleMessage("فلترة"),
        "filter_apply": MessageLookupByLibrary.simpleMessage("تطبيق الفلتر"),
        "filter_opt_12_3":
            MessageLookupByLibrary.simpleMessage("الطلبات من الساعه 12 الى 3"),
        "filter_opt_3_6":
            MessageLookupByLibrary.simpleMessage("الطلبات من الساعه 3 الى 6"),
        "filter_opt_6_9":
            MessageLookupByLibrary.simpleMessage("الطلبات من الساعه 6 الى 9"),
        "filter_opt_9_12":
            MessageLookupByLibrary.simpleMessage("الطلبات من الساعه 9 الى 12"),
        "filter_title": MessageLookupByLibrary.simpleMessage("فلترة الطلبات"),
        "finishService": MessageLookupByLibrary.simpleMessage("إنهاء الخدمة"),
        "from_orders": m5,
        "gallery": MessageLookupByLibrary.simpleMessage("معرض الصور"),
        "genericError": MessageLookupByLibrary.simpleMessage(
            "حدث خطأ. يرجى المحاولة مرة أخرى"),
        "getVerificationCode":
            MessageLookupByLibrary.simpleMessage("احصل على رمز التحقق"),
        "gold_plan": MessageLookupByLibrary.simpleMessage("باقة ذهبية"),
        "helloName": m6,
        "help": MessageLookupByLibrary.simpleMessage("المساعدة"),
        "invalidHoursMsg":
            MessageLookupByLibrary.simpleMessage("من فضلك أدخل عدد ساعات صالح"),
        "invalidMinutesMsg":
            MessageLookupByLibrary.simpleMessage("من فضلك أدخل عدد دقائق صالح"),
        "invalidPhoneNumber":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال رقم هاتف صالح"),
        "keep_it_up": MessageLookupByLibrary.simpleMessage("واصل تميزك!"),
        "last_earnings": MessageLookupByLibrary.simpleMessage("آخر الأرباح"),
        "later": MessageLookupByLibrary.simpleMessage("لاحقًا"),
        "loading": MessageLookupByLibrary.simpleMessage("جاري التحميل..."),
        "locationPermissionDescription": MessageLookupByLibrary.simpleMessage(
            "يحتاج التطبيق إلى الوصول إلى موقعك في جميع الأوقات لتتبع موقعك وتقديم الخدمات. يرجى تفعيل إذن الموقع \'السماح في جميع الأوقات\'."),
        "locationPermissionRequired":
            MessageLookupByLibrary.simpleMessage("إذن الموقع مطلوب"),
        "location_disabled": MessageLookupByLibrary.simpleMessage(
            "مشاركة الموقع معطّلة. اضغط هنا لتفعيلها."),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("سجل دخولك"),
        "logoutConfirm": MessageLookupByLibrary.simpleMessage("نعم، بالتأكيد!"),
        "logoutTitle": MessageLookupByLibrary.simpleMessage("تسجيل الخروج!"),
        "mapAddress":
            MessageLookupByLibrary.simpleMessage("شارع الملك فهد، الرياض"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("تمييز كمقروء"),
        "mark_as_read": MessageLookupByLibrary.simpleMessage("تمييز كمقروء"),
        "minutesSeconds": MessageLookupByLibrary.simpleMessage("دقيقة : ثانية"),
        "monthly": MessageLookupByLibrary.simpleMessage("شهري"),
        "monthly_orders": MessageLookupByLibrary.simpleMessage("طلبات الشهر"),
        "monthly_profit": MessageLookupByLibrary.simpleMessage("أرباح الشهر"),
        "nMinutes": m7,
        "nMinutesToFinish": m8,
        "name": MessageLookupByLibrary.simpleMessage("الاسم"),
        "navigate": MessageLookupByLibrary.simpleMessage("التنقل"),
        "needHelp": MessageLookupByLibrary.simpleMessage(
            "تحتاج مساعدة؟ تواصل معنا هنا"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "no": MessageLookupByLibrary.simpleMessage("لا"),
        "no_internet":
            MessageLookupByLibrary.simpleMessage("لا يوجد اتصال بالانترنت"),
        "no_orders": MessageLookupByLibrary.simpleMessage("لا توجد طلبات"),
        "notification1Subtitle": MessageLookupByLibrary.simpleMessage(
            "استمتع في التسوّق بينما نغسلها."),
        "notification1Title":
            MessageLookupByLibrary.simpleMessage("غسيل سيارتك بدأ! 🚗"),
        "notification2Subtitle":
            MessageLookupByLibrary.simpleMessage("تم غسيل سيارتك بنجاح."),
        "notification2Title":
            MessageLookupByLibrary.simpleMessage("سيارتك جاهزة جميلة! ✨"),
        "notification3Subtitle":
            MessageLookupByLibrary.simpleMessage("احجز غسيلك القادم الآن."),
        "notification3Title":
            MessageLookupByLibrary.simpleMessage("تم تسليم سيارتك! 🌺"),
        "notification4Subtitle": MessageLookupByLibrary.simpleMessage(
            "سائقنا في الطريق لاستلام السيارة."),
        "notification4Title":
            MessageLookupByLibrary.simpleMessage("طلبك قيد التنفيذ 🧽"),
        "notification5Subtitle": MessageLookupByLibrary.simpleMessage(
            "سيارتك ستتلقى غسيلًا دوريًا."),
        "notification5Title":
            MessageLookupByLibrary.simpleMessage("اشتراكك وصل! 🧼"),
        "notifications": MessageLookupByLibrary.simpleMessage("الاشعارات"),
        "notificationsTitle": MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "notifications_messages":
            MessageLookupByLibrary.simpleMessage("إشعارات الرسائل"),
        "notifications_offers":
            MessageLookupByLibrary.simpleMessage("إشعارات العروض"),
        "notifications_payment":
            MessageLookupByLibrary.simpleMessage("إشعارات إتمام الدفع"),
        "notifications_reminders":
            MessageLookupByLibrary.simpleMessage("إشعارات التذكير"),
        "notifications_title":
            MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "onboardingDescription": MessageLookupByLibrary.simpleMessage(
            "خدمة غسيل سيارات متنقلة نقدم الخدمة في مكان العميل بواسطة فريق مؤهل ومجهز"),
        "oneHour": MessageLookupByLibrary.simpleMessage("ساعة"),
        "openLocationSettings":
            MessageLookupByLibrary.simpleMessage("فتح إعدادات الموقع"),
        "orderAlreadyCompleted":
            MessageLookupByLibrary.simpleMessage("هذا الطلب مكتمل بالفعل"),
        "orderCompletedSuccess":
            MessageLookupByLibrary.simpleMessage("تم إنهاء الطلب بنجاح"),
        "orderProgressTitle":
            MessageLookupByLibrary.simpleMessage("تقدم الطلب"),
        "order_number": MessageLookupByLibrary.simpleMessage("رقم الطلب"),
        "orders_count": m9,
        "orders_current": MessageLookupByLibrary.simpleMessage("الحالية"),
        "orders_past": MessageLookupByLibrary.simpleMessage("السابقة"),
        "orders_so_far_title":
            MessageLookupByLibrary.simpleMessage("عدد الطلبات حتى الآن"),
        "orders_title": MessageLookupByLibrary.simpleMessage("الطلبات"),
        "orders_upcoming": MessageLookupByLibrary.simpleMessage("القادمة"),
        "other": MessageLookupByLibrary.simpleMessage("أخرى"),
        "package": MessageLookupByLibrary.simpleMessage("الباقة"),
        "package_silver": MessageLookupByLibrary.simpleMessage("الفضية"),
        "packages": MessageLookupByLibrary.simpleMessage("الباقات"),
        "pauseTemporarily": MessageLookupByLibrary.simpleMessage("إيقاف مؤقت"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "phoneNumberChangedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم تغيير رقم الهاتف بنجاح"),
        "phoneNumberHint": MessageLookupByLibrary.simpleMessage("0000..."),
        "phoneNumberNotAvailable":
            MessageLookupByLibrary.simpleMessage("رقم الهاتف غير متاح"),
        "pressBackAgainToExit": MessageLookupByLibrary.simpleMessage(
            "اضغط رجوع مرة أخرى للخروج من التطبيق."),
        "previousOrders":
            MessageLookupByLibrary.simpleMessage("الطلبات السابقة"),
        "privacy_policy":
            MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
        "privacy_title": MessageLookupByLibrary.simpleMessage("الخصوصية"),
        "profile_email": MessageLookupByLibrary.simpleMessage("عنوان البريد"),
        "profile_name_sample":
            MessageLookupByLibrary.simpleMessage("سارة محمد"),
        "profile_phone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "profile_title": MessageLookupByLibrary.simpleMessage("حسابي الشخصي"),
        "profile_username":
            MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
        "rateApp": MessageLookupByLibrary.simpleMessage("تقييم التطبيق"),
        "refund_cancellation_policy":
            MessageLookupByLibrary.simpleMessage("سياسة الاسترداد والإلغاء"),
        "registerNow": MessageLookupByLibrary.simpleMessage("سجل الآن"),
        "registerRequiredMessage": MessageLookupByLibrary.simpleMessage(
            "يجب عليك التسجيل أو تسجيل الدخول للمتابعة واستخدام هذه الميزة."),
        "registerRequiredTitle":
            MessageLookupByLibrary.simpleMessage("مطلوب التسجيل"),
        "resendCode": MessageLookupByLibrary.simpleMessage("أعد إرسال الرمز."),
        "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
        "roleDelegate": MessageLookupByLibrary.simpleMessage("مندوب"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "searchNotifications":
            MessageLookupByLibrary.simpleMessage("ابحث في الإشعارات"),
        "search_hint": MessageLookupByLibrary.simpleMessage(
            "ابحث عن ما يدور ببالك......."),
        "security_and_privacy":
            MessageLookupByLibrary.simpleMessage("الأمان والخصوصية"),
        "serviceProgress": MessageLookupByLibrary.simpleMessage("تقدم الخدمة"),
        "service_example": m10,
        "service_inside_out":
            MessageLookupByLibrary.simpleMessage("غسيل خارجي وداخلي"),
        "service_label": MessageLookupByLibrary.simpleMessage("الخدمة"),
        "service_title": MessageLookupByLibrary.simpleMessage("غسيل خارجي"),
        "service_type": MessageLookupByLibrary.simpleMessage("نوع الخدمه"),
        "service_undefined":
            MessageLookupByLibrary.simpleMessage("خدمة غير محددة"),
        "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "shareWithFriends":
            MessageLookupByLibrary.simpleMessage("شارك مع أصدقائك"),
        "start": MessageLookupByLibrary.simpleMessage("ابدأ"),
        "startService": MessageLookupByLibrary.simpleMessage("بدء الخدمه"),
        "status_assigned": MessageLookupByLibrary.simpleMessage("معين"),
        "status_availableNow":
            MessageLookupByLibrary.simpleMessage("متاح الآن"),
        "status_cancelled": MessageLookupByLibrary.simpleMessage("ملغي"),
        "status_completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
        "status_in_progress":
            MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
        "status_label": MessageLookupByLibrary.simpleMessage("الحالة"),
        "status_pending": MessageLookupByLibrary.simpleMessage("الانتظار"),
        "status_unavailable": MessageLookupByLibrary.simpleMessage("غير متاح"),
        "step_arrival": MessageLookupByLibrary.simpleMessage("الوصول للموقع"),
        "step_checkCar":
            MessageLookupByLibrary.simpleMessage("التحقق من السيارة"),
        "step_drying": MessageLookupByLibrary.simpleMessage("التجفيف"),
        "step_finishService":
            MessageLookupByLibrary.simpleMessage("إنهاء الخدمة"),
        "step_startWashing": MessageLookupByLibrary.simpleMessage("بدء الغسيل"),
        "support": MessageLookupByLibrary.simpleMessage("الدعم"),
        "terms_conditions":
            MessageLookupByLibrary.simpleMessage("الشروط والأحكام"),
        "threeHours": MessageLookupByLibrary.simpleMessage("ثلاث ساعات"),
        "timeRange": m11,
        "timeYesterday": MessageLookupByLibrary.simpleMessage("أمس"),
        "time_label": MessageLookupByLibrary.simpleMessage("الوقت"),
        "today": MessageLookupByLibrary.simpleMessage("اليوم"),
        "today_earnings": MessageLookupByLibrary.simpleMessage("أرباح اليوم"),
        "today_orders": MessageLookupByLibrary.simpleMessage("طلبات اليوم"),
        "today_profit": MessageLookupByLibrary.simpleMessage("أرباح اليوم"),
        "tryMobileWashComfort":
            MessageLookupByLibrary.simpleMessage("جرب راحة الغسيل المتنقل"),
        "twoDaysAgo": MessageLookupByLibrary.simpleMessage("منذ يومين"),
        "twoHours": MessageLookupByLibrary.simpleMessage("ساعتين"),
        "unableToLoadContactInfo":
            MessageLookupByLibrary.simpleMessage("تعذر تحميل معلومات الاتصال"),
        "unableToOpenWhatsApp":
            MessageLookupByLibrary.simpleMessage("تعذر فتح واتساب"),
        "unableToSendEmail": MessageLookupByLibrary.simpleMessage(
            "تعذر إرسال البريد الإلكتروني"),
        "unavailableForLabel":
            MessageLookupByLibrary.simpleMessage("غير متاح لمدة"),
        "unread": MessageLookupByLibrary.simpleMessage("غير مقروء"),
        "userPhoneNumber":
            MessageLookupByLibrary.simpleMessage("+966 1515 1511 333"),
        "user_agreement":
            MessageLookupByLibrary.simpleMessage("اتفاقية الاستخدام"),
        "verify": MessageLookupByLibrary.simpleMessage("التحقق"),
        "view": MessageLookupByLibrary.simpleMessage("عرض"),
        "wallet": MessageLookupByLibrary.simpleMessage("محفظتك"),
        "washes_count": MessageLookupByLibrary.simpleMessage("عدد الغسلات"),
        "welcomeKodGhaseel":
            MessageLookupByLibrary.simpleMessage("حياك في كــــود الغسيل"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("واتساب"),
        "writeMessage": MessageLookupByLibrary.simpleMessage("اكتب رسالة..."),
        "yes": MessageLookupByLibrary.simpleMessage("نعم"),
        "yesterday": MessageLookupByLibrary.simpleMessage("أمس"),
        "you_got_this":
            MessageLookupByLibrary.simpleMessage("إنت قدّها، كفو! 💪"),
        "yourProgress": MessageLookupByLibrary.simpleMessage("تقدمك")
      };
}
