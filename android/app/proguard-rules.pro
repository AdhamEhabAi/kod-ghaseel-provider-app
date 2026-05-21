# ============================================================
# Kod Ghaseel Provider App — ProGuard / R8 rules
# ============================================================

# --- Flutter ---
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.**

# --- Kotlin ---
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }
-dontwarn kotlin.**

# --- Firebase ---
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# --- Firebase Messaging ---
-keep class com.google.firebase.messaging.** { *; }

# --- Firebase Analytics ---
-keep class com.google.android.gms.measurement.** { *; }

# --- Google Maps ---
-keep class com.google.android.gms.maps.** { *; }
-keep interface com.google.android.gms.maps.** { *; }
-keep class com.google.maps.android.** { *; }
-dontwarn com.google.android.gms.maps.**

# --- OkHttp / Dio (via Dart native) ---
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# --- location Flutter plugin ---
-keep class com.lyokone.location.** { *; }
-dontwarn com.lyokone.location.**

# --- permission_handler plugin ---
-keep class com.baseflow.permissionhandler.** { *; }
-dontwarn com.baseflow.permissionhandler.**

# --- flutter_local_notifications ---
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.flutterlocalnotifications.**

# --- image_picker ---
-keep class io.flutter.plugins.imagepicker.** { *; }

# --- shared_preferences ---
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# --- url_launcher ---
-keep class io.flutter.plugins.urllauncher.** { *; }

# --- device_info_plus ---
-keep class dev.fluttercommunity.plus.device_info.** { *; }

# --- connectivity_plus ---
-keep class dev.fluttercommunity.plus.connectivity.** { *; }

# --- internet_connection_checker ---
-keep class com.example.internet_connection_checker.** { *; }

# --- Gson / JSON serialization (if used) ---
-keepattributes Signature
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }

# --- App models (prevent stripping of JSON-serialised model classes) ---
-keep class com.skada.kodghaseelprovider.** { *; }

# --- Dart VM entry points (background isolates, Dart native callbacks) ---
-keep @interface dart.annotation.DartName
-keepclasseswithmembers class * {
    @dart.annotation.DartName *;
}

# --- Prevent stripping of classes used via reflection ---
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# --- Remove debug logging in release (optional, reduces APK size) ---
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int d(...);
    public static int i(...);
}
