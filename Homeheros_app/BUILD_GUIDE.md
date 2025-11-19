# HomeHeros Build Guide

## EAS Build Configuration

### Build Profiles

#### 1. Development Build (APK)
```bash
eas build --profile development --platform android
```
- **Purpose**: Testing with development client
- **Output**: APK file
- **Distribution**: Internal testing
- **Includes**: Development tools and debugging

#### 2. Preview Build (APK) ⭐ **RECOMMENDED FOR TESTING**
```bash
eas build --profile preview --platform android
```
- **Purpose**: Testing production-like build
- **Output**: APK file (easy to install)
- **Distribution**: Internal testing
- **Includes**: Production code without store submission

#### 3. Production Build (AAB)
```bash
eas build --profile production --platform android
```
- **Purpose**: Play Store submission
- **Output**: AAB (Android App Bundle)
- **Distribution**: Play Store
- **Includes**: Optimized production build

### iOS Builds

#### Preview Build (iOS)
```bash
eas build --profile preview --platform ios
```
- **Purpose**: TestFlight or Ad-hoc distribution
- **Output**: IPA file
- **Distribution**: Internal testing

#### Production Build (iOS)
```bash
eas build --profile production --platform ios
```
- **Purpose**: App Store submission
- **Output**: IPA file
- **Distribution**: App Store

## Quick Start

### Prerequisites

1. **Install EAS CLI**
```bash
npm install -g eas-cli
```

2. **Login to Expo**
```bash
eas login
```

3. **Configure Project** (Already done!)
```bash
eas build:configure
```

### Build Test APK

**For Testing (Recommended):**
```bash
cd Homeheros_app
eas build --profile preview --platform android
```

This will:
1. ✅ Build production-ready code
2. ✅ Create APK file (easy to install)
3. ✅ Include all features
4. ✅ Use Supabase production environment
5. ✅ Generate downloadable link

### Build Both Platforms

```bash
eas build --profile preview --platform all
```

## Configuration Details

### eas.json Structure

```json
{
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal",
      "android": { "buildType": "apk" }
    },
    "preview": {
      "distribution": "internal",
      "android": { "buildType": "apk" }
    },
    "production": {
      "android": { "buildType": "aab" }
    }
  }
}
```

### Environment Variables

All profiles include:
- `EXPO_PUBLIC_SUPABASE_URL`
- `EXPO_PUBLIC_SUPABASE_KEY`

These are automatically injected during build.

## app.json Configuration

### Key Settings

```json
{
  "expo": {
    "name": "HomeHeros",
    "slug": "homeheros",
    "version": "1.0.0",
    "ios": {
      "bundleIdentifier": "com.homeheros.customer"
    },
    "android": {
      "package": "com.homeheros.customer",
      "permissions": [
        "ACCESS_FINE_LOCATION",
        "ACCESS_COARSE_LOCATION"
      ]
    }
  }
}
```

## Build Process

### 1. Start Build

```bash
eas build --profile preview --platform android
```

### 2. Build Process
- ✅ Uploads code to EAS servers
- ✅ Installs dependencies
- ✅ Compiles native code
- ✅ Creates APK/AAB
- ✅ Generates download link

### 3. Download Build

After build completes:
- Visit: https://expo.dev/accounts/[your-account]/projects/homeheros/builds
- Download APK file
- Install on Android device

## Installing APK on Device

### Method 1: Direct Download
1. Open build URL on Android device
2. Download APK
3. Allow installation from unknown sources
4. Install

### Method 2: ADB Install
```bash
adb install path/to/homeheros.apk
```

### Method 3: Share File
1. Download APK to computer
2. Transfer to device (USB, cloud, etc.)
3. Open file on device
4. Install

## Build Commands Reference

### Android Builds

```bash
# Development APK
eas build -p android --profile development

# Preview APK (Testing)
eas build -p android --profile preview

# Production AAB (Play Store)
eas build -p android --profile production

# Local build (if configured)
eas build -p android --profile preview --local
```

### iOS Builds

```bash
# Preview IPA (TestFlight)
eas build -p ios --profile preview

# Production IPA (App Store)
eas build -p ios --profile production
```

### Both Platforms

```bash
# Build both at once
eas build --profile preview --platform all
```

## Troubleshooting

### Build Fails

**Check:**
1. ✅ All dependencies installed
2. ✅ No syntax errors
3. ✅ Environment variables set
4. ✅ EAS CLI up to date

**Fix:**
```bash
npm install
eas build:configure
eas build --profile preview --platform android --clear-cache
```

### APK Won't Install

**Check:**
1. ✅ "Install from unknown sources" enabled
2. ✅ Enough storage space
3. ✅ Not already installed (uninstall first)

### App Crashes

**Check:**
1. ✅ Supabase credentials correct
2. ✅ All required permissions granted
3. ✅ Check device logs: `adb logcat`

## Build Optimization

### Reduce Build Time

```json
{
  "build": {
    "preview": {
      "android": {
        "buildType": "apk",
        "gradleCommand": ":app:assembleRelease"
      }
    }
  }
}
```

### Smaller APK Size

```json
{
  "android": {
    "enableProguardInReleaseBuilds": true,
    "enableShrinkResourcesInReleaseBuilds": true
  }
}
```

## Version Management

### Update Version

**app.json:**
```json
{
  "expo": {
    "version": "1.0.1",
    "android": {
      "versionCode": 2
    },
    "ios": {
      "buildNumber": "2"
    }
  }
}
```

### Build with Version

```bash
eas build --profile preview --platform android
```

Version is automatically read from app.json.

## Distribution

### Internal Testing

1. **Build preview APK**
2. **Share download link**
3. **Testers install directly**

### Play Store (Production)

1. **Build production AAB**
```bash
eas build --profile production --platform android
```

2. **Submit to Play Store**
```bash
eas submit --platform android
```

### TestFlight (iOS)

1. **Build preview IPA**
```bash
eas build --profile preview --platform ios
```

2. **Submit to TestFlight**
```bash
eas submit --platform ios
```

## Monitoring Builds

### Check Build Status

```bash
eas build:list
```

### View Build Logs

```bash
eas build:view [build-id]
```

### Cancel Build

```bash
eas build:cancel [build-id]
```

## Best Practices

### For Testing
- ✅ Use `preview` profile
- ✅ Build APK (not AAB)
- ✅ Test on multiple devices
- ✅ Check all features work

### For Production
- ✅ Use `production` profile
- ✅ Build AAB for Play Store
- ✅ Test preview build first
- ✅ Update version numbers

### Security
- ✅ Never commit API keys
- ✅ Use environment variables
- ✅ Rotate keys regularly
- ✅ Use different keys for dev/prod

## Quick Reference

### Most Common Commands

```bash
# Build test APK
eas build -p android --profile preview

# Check build status
eas build:list

# Download latest build
# Visit: https://expo.dev

# Install on device
adb install homeheros.apk
```

## Support

### EAS Documentation
https://docs.expo.dev/build/introduction/

### Expo Forums
https://forums.expo.dev/

### Check Build Logs
https://expo.dev/accounts/[your-account]/projects/homeheros/builds

---

## ✅ Ready to Build!

Your EAS configuration is complete and ready for building test APKs.

**Recommended command for testing:**
```bash
cd Homeheros_app
eas build --profile preview --platform android
```

This will create a production-ready APK that you can install on any Android device for testing!
