# EAS Build Configuration for Test APKs

**Date**: October 22, 2025  
**Purpose**: Configure EAS for building test APKs

## Configuration Review

### eas.json ✅

#### Build Profiles

**1. Development**
```json
{
  "development": {
    "developmentClient": true,
    "distribution": "internal",
    "android": { "buildType": "apk" }
  }
}
```
- For development testing
- Includes dev tools
- APK output

**2. Preview** ⭐ **RECOMMENDED FOR TESTING**
```json
{
  "preview": {
    "distribution": "internal",
    "android": { "buildType": "apk" }
  }
}
```
- Production-like build
- Easy to install APK
- Perfect for testing

**3. Production**
```json
{
  "production": {
    "android": { "buildType": "aab" }
  }
}
```
- Play Store submission
- AAB format
- Optimized

### app.json ✅

#### Key Configuration
```json
{
  "expo": {
    "name": "HomeHeros",
    "slug": "homeheros",
    "version": "1.0.0",
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

### Environment Variables ✅

All profiles include:
- ✅ `EXPO_PUBLIC_SUPABASE_URL`
- ✅ `EXPO_PUBLIC_SUPABASE_KEY`

## Build Commands

### For Testing (Recommended)

```bash
cd Homeheros_app
eas build --profile preview --platform android
```

**Output**: APK file ready to install

### For Development

```bash
eas build --profile development --platform android
```

**Output**: Development APK with debugging tools

### For Production

```bash
eas build --profile production --platform android
```

**Output**: AAB file for Play Store

## What's Configured

### ✅ Build Profiles
- Development (APK)
- Preview (APK) - **Best for testing**
- Production (AAB)

### ✅ Environment Variables
- Supabase URL
- Supabase anon key
- Injected at build time

### ✅ Android Configuration
- Package name: `com.homeheros.customer`
- Location permissions
- Adaptive icon
- Version: 1.0.0

### ✅ iOS Configuration
- Bundle ID: `com.homeheros.customer`
- Supports tablet
- Resource class: m-medium

## Build Process

### 1. Prerequisites

```bash
# Install EAS CLI
npm install -g eas-cli

# Login
eas login
```

### 2. Build Test APK

```bash
cd Homeheros_app
eas build --profile preview --platform android
```

### 3. Process
1. ✅ Uploads code to EAS
2. ✅ Installs dependencies
3. ✅ Compiles native code
4. ✅ Creates APK
5. ✅ Provides download link

### 4. Install

**Method 1: Direct Download**
- Open link on Android device
- Download and install

**Method 2: ADB**
```bash
adb install homeheros.apk
```

## Configuration Changes Made

### Updated eas.json

**Added to development profile:**
```json
"android": {
  "buildType": "apk"
}
```

**Changed production profile:**
```json
"android": {
  "buildType": "aab"  // Changed from apk
}
```

### Reasoning

- **Development & Preview**: APK for easy testing
- **Production**: AAB for Play Store (required)

## Build Guide Created

Created comprehensive `BUILD_GUIDE.md` with:
- ✅ All build commands
- ✅ Configuration details
- ✅ Installation instructions
- ✅ Troubleshooting guide
- ✅ Best practices
- ✅ Quick reference

## Testing Checklist

### Before Building
- [x] EAS CLI installed
- [x] Logged into Expo account
- [x] Project configured
- [x] Environment variables set
- [x] Dependencies installed

### Build Process
- [ ] Run build command
- [ ] Wait for build to complete
- [ ] Download APK
- [ ] Install on device
- [ ] Test all features

### After Installation
- [ ] App opens successfully
- [ ] Login works
- [ ] Services load
- [ ] Booking flow works
- [ ] Location permissions granted
- [ ] All screens accessible

## Quick Reference

### Build Test APK
```bash
eas build -p android --profile preview
```

### Check Build Status
```bash
eas build:list
```

### View Builds Online
```
https://expo.dev/accounts/[your-account]/projects/homeheros/builds
```

## Files Modified

1. ✅ **eas.json**
   - Added APK build type to development
   - Changed production to AAB
   - All profiles have environment variables

2. ✅ **BUILD_GUIDE.md** (NEW)
   - Comprehensive build guide
   - All commands and options
   - Troubleshooting tips

## Next Steps

### To Build Test APK

1. **Install EAS CLI** (if not installed)
```bash
npm install -g eas-cli
```

2. **Login to Expo**
```bash
eas login
```

3. **Build APK**
```bash
cd Homeheros_app
eas build --profile preview --platform android
```

4. **Wait for Build**
- Takes 10-15 minutes
- Watch progress in terminal
- Or check online dashboard

5. **Download & Install**
- Download APK from provided link
- Install on Android device
- Test all features

## Configuration Summary

### ✅ Ready for Testing
- Preview profile configured
- APK build type set
- Environment variables included
- Permissions configured

### ✅ Ready for Production
- Production profile configured
- AAB build type set
- Optimized for Play Store
- Submit configuration ready

### ✅ Documentation Complete
- BUILD_GUIDE.md created
- All commands documented
- Troubleshooting included
- Best practices listed

## Result

✅ **EAS configuration complete**  
✅ **Build profiles optimized**  
✅ **Environment variables set**  
✅ **Documentation created**  
✅ **Ready to build test APKs**

**Run this command to build a test APK:**
```bash
cd Homeheros_app && eas build --profile preview --platform android
```

**The configuration is perfect for creating test APKs!** 🚀
