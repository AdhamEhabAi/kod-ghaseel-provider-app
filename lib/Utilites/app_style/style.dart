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
}) => FlyweightTextStyles.get(
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
        hintStyle: _ts(fontFamily: fontFamily, fontSize: 14.sp),
        labelStyle: _ts(fontFamily: fontFamily, fontSize: 14.sp),
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
  static Color primaryColorOpacity52 = const Color(0x8501D0FE);
  static Color textGreyColor = const Color(0x47101828);
  static const Color offWhite = Color(0xFFE8E8E8);

  static Color textFieldBorderColor = const Color(0xffEEEEEE);
  static Color textSecondaryColor = const Color(0xFF475467);
  static Color textGreyColorCalender = const Color(0xFF979797);
  static Color rateTextColorGold = const Color(0xffF6C54D);
  static Color greenColor = const Color(0xff32D34B);
  static Color subTitle = const Color(0xFF575757);

  static const Color redErrorColor = Color(0xffdc2626);
  static const Color greyColor = Color(0xFF939292);
  static const Color greyNewText = Color(0xFFF8F8F8);
  static const Color greyNewTextBorder = Color(0xFFF1F1F1);
  static const Color black = Color(0xFF1E1E1E);
  static const Color white = Colors.white;
  static const Color green = Colors.green;
  static const Color red = Colors.red;

  // NOTE: Your current fonts all point to 'Poppins'. Keep as-is.
  static const String cairoFont = 'Cairo';

  static const Color grey = Color(0xFFE0E0E0);
  static const Color lightGrey = Colors.grey;
  static const Color whereto = Color(0xFFF2F2F2);

  // ----------------- spaces
  static EdgeInsetsGeometry paddingContainerHome = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 12.h,
  );

  static ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            ZoomPageTransitionsBuilder(), // smooth zoom hero
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    bottomSheetTheme: BottomSheetThemeData(
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
