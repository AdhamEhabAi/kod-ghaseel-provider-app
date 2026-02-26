# Release APK Build Guide

This guide explains how to build a signed release APK for the Kod Ghaseel Provider App.

## Prerequisites

✅ **Keystore Configuration Validated**
- `key.properties` file exists and contains all required properties
- Keystore file (`my-release-key.jks`) exists at `android/app/my-release-key.jks`
- All passwords and aliases are configured

## Configuration Files

### 1. `key.properties` (android/key.properties)
Contains the signing configuration:
```
storeFile=app/my-release-key.jks
storePassword=your-store-password
keyAlias=my-key-alias
keyPassword=your-key-password
```

**⚠️ Security Note:** This file is already in `.gitignore` and should NEVER be committed to version control.

### 2. `my-release-key.jks` (android/app/my-release-key.jks)
The keystore file used for signing the release APK.

**⚠️ Security Note:** This file is already in `.gitignore` and should NEVER be committed to version control.

### 3. `build.gradle.kts` (android/app/build.gradle.kts)
The build configuration automatically:
- Reads `key.properties` from the `android/` directory
- Validates all required properties are present
- Checks that the keystore file exists
- Configures release signing automatically
- Falls back to debug signing if `key.properties` is missing (with warnings)

## Validation

Before building, you can validate your keystore configuration by running:

```powershell
cd android
.\validate_keystore.ps1
```

This script checks:
- ✅ `key.properties` file exists
- ✅ All required properties are present and non-empty
- ✅ Keystore file exists at the specified path
- ✅ Keystore file is not empty
- ⚠️ Password strength (warnings only)

## Building the Release APK

### Option 1: Build APK
```bash
flutter build apk --release
```

The signed APK will be generated at:
`build/app/outputs/flutter-apk/app-release.apk`

### Option 2: Build App Bundle (for Google Play Store)
```bash
flutter build appbundle --release
```

The signed AAB will be generated at:
`build/app/outputs/bundle/release/app-release.aab`

## Build Configuration Details

The `build.gradle.kts` file includes:
- ✅ Automatic keystore validation
- ✅ Clear error messages if configuration is missing
- ✅ Automatic fallback to debug signing (with warnings)
- ✅ Release build type configured with proper signing

## Troubleshooting

### Error: "Keystore file not found"
- Verify the `storeFile` path in `key.properties` is correct
- Ensure the keystore file exists at `android/app/my-release-key.jks`
- The path in `key.properties` should be relative to the `android/` directory

### Error: "Missing required keystore properties"
- Ensure `key.properties` contains all four required properties:
  - `storeFile`
  - `storePassword`
  - `keyAlias`
  - `keyPassword`

### Error: "Keystore path is not a file"
- The path specified in `storeFile` must point to a file, not a directory

### Build uses debug signing instead of release
- Check that `key.properties` exists in the `android/` directory
- Run the validation script to identify issues
- Check the build output for warnings

## Security Best Practices

1. ✅ **Never commit** `key.properties` or `*.jks` files to version control
2. ✅ **Backup your keystore** file securely - if lost, you cannot update your app
3. ✅ **Use strong passwords** for both store and key passwords
4. ✅ **Store credentials securely** - consider using environment variables or secure vaults for CI/CD

## Current Configuration Status

✅ All validations passed!
- Keystore file: `android/app/my-release-key.jks` (2756 bytes)
- Key alias: `my-key-alias`
- Configuration validated and ready for release builds






