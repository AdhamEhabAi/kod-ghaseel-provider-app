import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
var keystoreConfigured = false

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    
    // Validate required properties
    val requiredProperties = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
    val missingProperties = requiredProperties.filter { keystoreProperties[it] == null || (keystoreProperties[it] as String).isBlank() }
    
    if (missingProperties.isNotEmpty()) {
        throw GradleException(
            "Missing required keystore properties in key.properties: ${missingProperties.joinToString(", ")}\n" +
            "Required properties: storeFile, storePassword, keyAlias, keyPassword"
        )
    }
    
    // Validate keystore file exists
    val storeFile = rootProject.file(keystoreProperties["storeFile"] as String)
    if (!storeFile.exists()) {
        throw GradleException(
            "Keystore file not found: ${storeFile.absolutePath}\n" +
            "Please ensure the keystore file exists at the specified path in key.properties"
        )
    }
    
    if (!storeFile.isFile) {
        throw GradleException("Keystore path is not a file: ${storeFile.absolutePath}")
    }
    
    keystoreConfigured = true
    println("✓ Keystore configuration validated successfully")
    println("  Store file: ${storeFile.absolutePath}")
    println("  Key alias: ${keystoreProperties["keyAlias"]}")
} else {
    println("⚠ Warning: key.properties not found. Release builds will use debug signing.")
    println("  To enable release signing, create android/key.properties with:")
    println("    storeFile=app/my-release-key.jks")
    println("    storePassword=your-store-password")
    println("    keyAlias=your-key-alias")
    println("    keyPassword=your-key-password")
}

android {
    namespace = "com.skada.kodghaseelprovider"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.14033849"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Unique app ID (must match Firebase project registration)
        applicationId = "com.skada.kodghaseelprovider"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    signingConfigs {
        create("release") {
            if (keystoreConfigured) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = rootProject.file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }
    buildTypes {
        release {
            signingConfig = if (keystoreConfigured) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            // Code shrinking, obfuscation, and resource shrinking enabled for release.
            // Run: flutter build appbundle --release --obfuscate --split-debug-info=build/debug-symbols
            // Save build/debug-symbols — required to decode production crash stack traces.
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.4.0"))

    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")


}
