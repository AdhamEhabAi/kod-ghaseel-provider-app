import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ----------------------------
/// Flyweight for TextStyle
/// ----------------------------
@immutable
class _TextStyleKey {
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration;
  final Color? color;

  const _TextStyleKey({
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _TextStyleKey &&
              fontSize == other.fontSize &&
              fontWeight == other.fontWeight &&
              fontStyle == other.fontStyle &&
              fontFamily == other.fontFamily &&
              letterSpacing == other.letterSpacing &&
              wordSpacing == other.wordSpacing &&
              height == other.height &&
              decoration == other.decoration &&
              color == other.color;

  @override
  int get hashCode => Object.hash(
    fontSize,
    fontWeight,
    fontStyle,
    fontFamily,
    letterSpacing,
    wordSpacing,
    height,
    decoration,
    color,
  );
}

class FlyweightTextStyles {
  FlyweightTextStyles._();
  static final Map<_TextStyleKey, TextStyle> _cache = {};

  static TextStyle get({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? decoration,
    Color? color,
  }) {
    final key = _TextStyleKey(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      color: color,
    );
    final cached = _cache[key];
    if (cached != null) return cached;

    final style = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      color: color,
    );
    _cache[key] = style;
    return style;
  }

  static void clear() => _cache.clear();
}

/// Convenience helper to shorten calls inside AppStyle.
TextStyle _ts({
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  String? fontFamily,
  double? letterSpacing,
  double? wordSpacing,
  double? height,
  TextDecoration? decoration,
  Color? color,
}) =>
    FlyweightTextStyles.get(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      color: color,
    );

class AppStyle {
  static ThemeData getLightTheme(String languageCode) {
    // Theme depends on language font family + colors -> clear to avoid stale entries
    FlyweightTextStyles.clear();

    final fontFamily = cairoFont;

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: white,
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        titleTextStyle: _ts(
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 24.sp,
          color: black,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: _ts(
          fontFamily: fontFamily,
          color: black,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: _ts(
          fontFamily: fontFamily,
          fontSize: 14.sp,
        ),
        labelStyle: _ts(
          fontFamily: fontFamily,
          fontSize: 14.sp,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all<TextStyle>(
            _ts(fontFamily: fontFamily, fontSize: 16.sp),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all<TextStyle>(
            _ts(fontFamily: fontFamily, fontSize: 16.sp),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all<TextStyle>(
            _ts(
              fontFamily: AppStyle.cairoFont,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: bottomSheetBorderRadius),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }




  static Color primaryColor = const Color(0xFF01D0FE);
  static Color primaryColorOpacity10 = const Color(0x1A01D0FE);
  static Color lightYellowColor = const Color(0xffFFF6DB);
  static Color textGreyColor = const Color(0x47101828);
  static Color textFieldBorderColor = const Color(0xffEEEEEE);
  static Color textSecondaryColor = const Color(0xFF475467);
  static Color textGreyColorCalender = const Color(0xFF979797);
  static Color secColor = const Color(0xff04DCEF);
  static Color rateTextColorGold = const Color(0xffF6C54D);
  static Color greenColor = const Color(0xff32D34B);
  static Color greenColorOpacity15 = const Color(0x2632d34b);
  static Color bottomBar = const Color(0xff9200ED);
  static const Color cardBgLightColor = Color(0xff999999);
  static const Color cardBgColor = Color(0xff363636);
  static const Color redBan = Color(0xffFF2C20);
  static Color blueColor = const Color(0xff04DCEF);
  static const Color lightBlue = Color(0xFFFAFAFA);
  static Color rewardContainer = const Color(0xFF200541);
  static Color rewardContainer2 = const Color(0xFF6303DD);
  static Color darkPrimaryColor = const Color(0xff004ec2);
  static Color subTitle = const Color(0xFF575757);

  static const Color redErrorColor = Color(0xffdc2626);
  static const Color offWhite = Color(0xFFE8E8E8);
  static const Color primaryLight = Color(0xFFD3C0EB);
  static const Color ofWhite = Color(0xFFF7F7F7);
  static const Color greyColor = Color(0xFF939292);
  static const Color greyNew = Color(0xFF727272);
  static const Color greyNewText = Color(0xFFF8F8F8);
  static const Color greyNewIcon = Color(0xFFF9F9F9);

  static const Color greyNewTextBorder = Color(0xFFF1F1F1);

  static const Color black = Color(0xFF1E1E1E);
  static Color purple50 = const Color(0xFFeee6f8);
  static Color purple100 = const Color(0xFFcab0ea);
  static Color purple200 = const Color(0xFFb08ae0);
  static Color purple300 = const Color(0xFF8c54d2);
  static Color purple400 = const Color(0xFF7533c9);
  static Color purple500 = const Color(0xFF5300bc);
  static Color purple600 = const Color(0xFF4c00ab);
  static Color purple700 = const Color(0xFF3b0085);
  static Color purple800 = const Color(0xFF2e0067);
  static Color purple900 = const Color(0xFF23004f);
  static const Color white = Colors.white;
  static const Color whitePink = Color(0xFFECE8FF);
  static Color silver = const Color(0xFFF3F3F3);
  static Color gold = const Color(0xFFF6CA3C);
  static Color plat = const Color(0xFFE5F3FF);
  static const Color otpColor = Color(0xffF6F2FC);
  static Color levelCard = const Color(0xFFF9F9F9);
  static Color levelText = const Color(0xFF6B6B6B);
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color underDevelopment = Color(0xFF414141);
  static Color rewardTextColor = const Color(0xFF04DCEF);
  static Color rewardTextColor2 = const Color(0xFFEAEAEA);
  static Color rewardTextColor3 = const Color(0xFF6B6B6B);
  static Color cardColor = const Color(0xff3B82F6);

  // NOTE: Your current fonts all point to 'Poppins'. Keep as-is.
  static const String cairoFont = 'Cairo';


  static const Color grey = Color(0xFFE0E0E0);
  static const Color lightGrey = Colors.grey;
  static const Color lighterGrey = Color(0xFF6B6B6B);
  static const Color border = Color(0xFFEDEDED);
  static const Color white01 = Color(0xFFFAFAFA);
  static const Color divider = Color(0xFFF3F3F3);
  static const Color customContainer = Color(0xFFE7E7E7);
  static const Color purple = Color(0xFF6A00D4);
  static const Color pink = Color(0xFFF63BD8);
  static const Color lightGreen = Color(0xFF19B791);
  static const Color whiteSmoke = Color(0xFFE4EDFB);
  static const Color grayBorder = Color(0xFFF7F7F7);
  static const Color vibrantBlue = Color(0xFF4DAAFF);
  static const Color whereto = Color(0xFFF2F2F2);
  static const Color chatSender = Color(0xFF3B82F6);
  static const Color chatReceiver = Color(0xFFEFEFEF);
  static const Color scaffoldBackground = Color(0xFFF2F4F5);



  // ----------------- spaces
  static EdgeInsetsGeometry paddingContainerHome = EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);


  static setPinkMode(bool value) {
    if (value) {
      primaryColor = AppStyle.pink;
      darkPrimaryColor = AppStyle.pink;
      cardColor = AppStyle.pink;
    } else {
      primaryColor = const Color(0xff006ed4);
      darkPrimaryColor = const Color(0xff004ec2);
      cardColor = const Color(0xff3B82F6);
    }
    // Colors changed -> invalidate cached TextStyles
    FlyweightTextStyles.clear();
  }

  static ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(), // smooth zoom hero
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppStyle.white,
      shape: RoundedRectangleBorder(borderRadius: bottomSheetBorderRadius),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    fontFamily: cairoFont,
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(
      backgroundColor: white,
      titleTextStyle: _ts(
        fontWeight: FontWeight.bold,
        fontSize: 24.sp,
        color: black,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: _ts(
        color: black,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: _ts(
        color: greyColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
      ),
      bodyMedium: _ts(
        color: white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: _ts(
        color: white,
        fontSize: 14.spMin,
        fontWeight: FontWeight.w400,
        fontFamily: cairoFont,
        height: 0.10,
      ),
      titleLarge: _ts(
        color: black,
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        fontFamily: cairoFont,
      ),
      titleSmall: _ts(
        color: black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w200,
      ),
      labelSmall: _ts(
        color: black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
        fontFamily: cairoFont,
      ),
      labelLarge: _ts(
        color: black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: _ts(
        color: black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: _ts(
        color: white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: _ts(
        fontSize: 16.sp,
        fontWeight: FontWeight.w200,
        color: white,
      ),
      headlineMedium: _ts(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleMedium: _ts(
        color: white,
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
      ),
      displayLarge: _ts(
        color: black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: _ts(
        color: black,
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  static BorderRadiusGeometry bottomSheetBorderRadius = BorderRadius.only(
    topRight: Radius.circular(24.r),
    topLeft: Radius.circular(24.r),
  );

  static BorderRadius defaultBorderRadius = BorderRadius.circular(10.r);

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true);
}
