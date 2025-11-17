# Complete iOS App Store Deployment Guide

## 📋 Prerequisites

- ✅ Mac with Xcode installed
- ✅ Apple Developer Account ($99/year)
- ✅ Completed Flutter app ready for release
- ✅ App tested on physical iOS device

---

## Step 1: Apple Developer Account Setup

### **1.1 Enroll in Apple Developer Program**

1. Go to [developer.apple.com](https://developer.apple.com)
2. Click "Account"
3. Sign in with Apple ID
4. Enroll in Apple Developer Program ($99/year)
5. Wait for approval (usually 24-48 hours)

---

## Step 2: App Identifiers

### **2.1 Create Bundle ID**

1. Go to [developer.apple.com/account](https://developer.apple.com/account)
2. Click "Certificates, IDs & Profiles"
3. Click "Identifiers" → "+"
4. Select "App IDs" → Continue
5. Choose "App" → Continue
6. Fill in:
   - **Description:** Your App Name
   - **Bundle ID:** `com.yourcompany.appname` (must match Xcode)
   - **Explicit** (not wildcard)
7. Select Capabilities (Push Notifications, Apple Pay, etc.)
8. Click "Continue" → "Register"

---

## Step 3: Certificates & Provisioning

### **3.1 Create Certificates**

**Development Certificate (for testing):**
1. Certificates → "+"
2. Select "iOS App Development"
3. Follow instructions to create CSR
4. Upload CSR
5. Download certificate
6. Double-click to install in Keychain

**Distribution Certificate (for App Store):**
1. Certificates → "+"
2. Select "iOS Distribution"
3. Create and upload CSR
4. Download and install

### **3.2 Create Provisioning Profiles**

**Development Profile:**
1. Profiles → "+"
2. Select "iOS App Development"
3. Select your App ID
4. Select your development certificate
5. Select test devices
6. Name it (e.g., "MyApp Dev")
7. Download and double-click to install

**Distribution Profile:**
1. Profiles → "+"
2. Select "App Store"
3. Select your App ID
4. Select distribution certificate
5. Name it (e.g., "MyApp Distribution")
6. Download and install

---

## Step 4: Xcode Configuration

### **4.1 Open Project in Xcode**

```bash
cd your_flutter_project
open ios/Runner.xcworkspace
```

### **4.2 Configure Signing**

1. Select "Runner" in project navigator
2. Select "Runner" target
3. Go to "Signing & Capabilities" tab

**Option A: Automatic Signing (Recommended)**
- Check "Automatically manage signing"
- Select your team
- Xcode handles certificates/profiles

**Option B: Manual Signing**
- Uncheck "Automatically manage signing"
- Select provisioning profiles manually
- For Debug: Use development profile
- For Release: Use distribution profile

### **4.3 General Settings**

In "General" tab:

- **Display Name:** App name shown on home screen
- **Bundle Identifier:** Match Apple Developer Portal (e.g., `com.yourcompany.appname`)
- **Version:** User-facing version (e.g., `1.0.0`)
- **Build:** Incremental build number (e.g., `1`)
- **Deployment Target:** Minimum iOS version (13.0+)

### **4.4 Info.plist Configuration**

Add all permission descriptions:

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to take photos</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access to save images</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show nearby stores</string>

<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access for voice messages</string>

<key>NSContactsUsageDescription</key>
<string>We need contacts access to invite friends</string>
```

### **4.5 App Icons**

1. Create app icons in all required sizes
2. Use [appicon.co](https://appicon.co) to generate all sizes
3. Add to `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
4. Required sizes:
   - iPhone: 60x60@2x, 60x60@3x
   - iPad: 76x76, 76x76@2x
   - App Store: 1024x1024

### **4.6 Launch Screen**

1. Edit `ios/Runner/Base.lproj/LaunchScreen.storyboard`
2. Or create custom launch screen
3. Keep it simple - shows while app loads

---

## Step 5: Build for Release

### **5.1 Update pubspec.yaml**

```yaml
version: 1.0.0+1  # version+buildNumber
```

### **5.2 Build IPA**

**Method 1: Flutter CLI**
```bash
# Clean first
flutter clean

# Get dependencies
flutter pub get

# Build IPA (includes signing)
flutter build ipa --release
```

**Method 2: Xcode Archive**
```bash
# Build without code signing
flutter build ios --release --no-codesign

# Then in Xcode:
# 1. Product → Scheme → Edit Scheme → Set to Release
# 2. Product → Archive
# 3. Wait for archive to complete
```

### **5.3 Common Build Issues**

**Issue: Code signing failed**
- Check certificates are installed in Keychain
- Check provisioning profiles are valid
- Ensure Bundle ID matches

**Issue: Missing capabilities**
- Enable in Xcode: Signing & Capabilities
- Enable in Developer Portal: App ID capabilities
- Regenerate provisioning profile

---

## Step 6: App Store Connect

### **6.1 Create App**

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Click "My Apps" → "+"
3. Click "New App"
4. Fill in:
   - **Platforms:** iOS
   - **Name:** App name (30 chars max)
   - **Primary Language:** English
   - **Bundle ID:** Select your registered Bundle ID
   - **SKU:** Unique ID (e.g., `MYAPP001`)
   - **User Access:** Full Access

### **6.2 App Information**

In App Store Connect → Your App:

**App Information:**
- **Name:** Full app name
- **Subtitle:** Short tagline (30 chars)
- **Category:** Primary and Secondary
- **Content Rights:** Who owns the content

**Pricing and Availability:**
- **Price:** Free or paid
- **Availability:** Select countries
- **Pre-orders:** Optional

**App Privacy:**
- Click "Get Started"
- Answer privacy questions
- Specify data collection practices

---

### **6.3 Prepare for Submission**

**Version Information:**
- **Screenshot Requirements:**
  - iPhone 6.7" (iPhone 14 Pro Max): 1290 x 2796
  - iPhone 6.5" (iPhone 11 Pro Max): 1242 x 2688
  - iPad Pro 12.9" (6th gen): 2048 x 2732
  - Use [screenshots.pro](https://screenshots.pro) or take from simulator

- **App Preview Videos:** Optional but recommended

- **Description:**
  - 170-word description
  - Highlight key features
  - Use keywords naturally

- **Keywords:** 100 characters, comma-separated

- **Support URL:** Website with support info

- **Marketing URL:** Optional website

- **Promotional Text:** 170 chars, can update anytime

**Rating:**
- Complete questionnaire
- Determines age rating (4+, 9+, 12+, 17+)

**App Review Information:**
- **Contact Info:** Your email and phone
- **Demo Account:** If app requires login
- **Notes:** Special instructions for reviewers
- **Attachments:** Any needed documents

---

## Step 7: Upload Build

### **7.1 Upload via Xcode**

1. After archiving (Step 5.2):
   - Window → Organizer → Archives
   - Select your archive
   - Click "Distribute App"
   - Select "App Store Connect"
   - Click "Upload"
   - Wait for processing (10-30 minutes)

### **7.2 Upload via Transporter**

1. Download Transporter from Mac App Store
2. Open Transporter
3. Drag IPA file (from `build/ios/ipa/`)
4. Click "Deliver"
5. Wait for upload

### **7.3 Select Build**

1. In App Store Connect → Your App
2. Go to version section
3. Click "+ Build"
4. Select uploaded build (may take time to process)
5. Answer export compliance questions

---

## Step 8: TestFlight (Optional but Recommended)

### **8.1 Internal Testing**

1. In App Store Connect → TestFlight
2. Add internal testers (up to 100)
3. They receive email invitation
4. Install TestFlight app
5. Test your app

### **8.2 External Testing**

1. Create new external testing group
2. Add testers (up to 10,000)
3. **Requires Beta App Review** (1-2 days)
4. Add testing notes
5. Submit for review
6. Once approved, testers get access

### **8.3 Collect Feedback**

- Monitor crash reports
- Read tester feedback
- Fix critical bugs
- Upload new builds as needed

---

## Step 9: Submit for Review

### **9.1 Final Checklist**

- [ ] All screenshots uploaded
- [ ] Description complete
- [ ] Keywords added
- [ ] Support URL working
- [ ] Privacy policy URL working
- [ ] Age rating completed
- [ ] Pricing set
- [ ] Build selected
- [ ] Export compliance answered
- [ ] Review notes added
- [ ] Demo account provided (if needed)

### **9.2 Submit**

1. Click "Add for Review" (top right)
2. Review all information
3. Click "Submit to App Review"
4. Wait for review

---

## Step 10: App Review Process

### **10.1 Timeline**

- **In Review:** 1-3 days typically
- **Processing:** After approval, 1-24 hours
- **Ready for Sale:** Live on App Store!

### **10.2 Possible Outcomes**

**Approved ✅**
- App goes live automatically (or on date you set)
- Celebrate! 🎉

**Rejected ❌**
- Read rejection reason carefully
- Common reasons:
  - Crashes
  - Broken features
  - Incomplete info
  - Guideline violations
  - Privacy issues
- Fix issues
- Resubmit

**Metadata Rejected**
- App is fine, but description/screenshots need changes
- Update metadata
- Resubmit

### **10.3 Track Status**

- Email notifications
- App Store Connect dashboard
- Push notifications in App Store Connect app

---

## Step 11: Post-Launch

### **11.1 Monitor**

- Crash reports in App Store Connect
- User reviews and ratings
- Download analytics
- Respond to reviews

### **11.2 Updates**

**For updates:**
1. Increment version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # version+build
   ```
2. Build new IPA
3. Upload to App Store Connect
4. Create new version
5. Fill in "What's New" section
6. Submit for review

---

## Common Rejection Reasons & Fixes

### **1. App Crashes**
- Test thoroughly before submission
- Fix all crashes
- Use Firebase Crashlytics

### **2. Incomplete Information**
- Ensure all metadata fields filled
- Add demo account if needed
- Clear screenshots

### **3. Design Guidelines**
- Follow Human Interface Guidelines
- Use native iOS components
- Ensure good UX

### **4. Privacy**
- Privacy policy required if collecting data
- Proper permission descriptions
- Privacy Manifest for iOS 17+

### **5. Payments**
- In-app purchases must use Apple's system
- Can't link to external payment

---

## Flutter-Specific Tips

### **Version Management**

In `pubspec.yaml`:
```yaml
version: 1.0.0+1
#        ─┬─  ─┬─
#         │    └─ Build number (must increment each upload)
#         └────── Version number (user-facing)
```

Can override via CLI:
```bash
flutter build ipa --build-name=1.0.1 --build-number=2
```

### **Build Modes**

```bash
# Debug (for development)
flutter run

# Profile (for performance testing)
flutter run --profile

# Release (for production)
flutter build ipa --release
```

### **Flavors (Dev/Staging/Prod)**

Configure multiple environments in Xcode schemes for different API endpoints.

---

## Troubleshooting

### **"No signing certificate found"**
1. Check certificates in Keychain Access
2. Create new certificate in Developer Portal
3. Download and install

### **"Provisioning profile doesn't match"**
1. Check Bundle ID matches everywhere
2. Regenerate provisioning profile
3. Download and install

### **"Missing required icon"**
1. Generate all icon sizes
2. Add to Assets.xcassets
3. Rebuild

### **"Invalid IPA"**
1. Ensure built with distribution certificate
2. Check capabilities match App ID
3. Try building from Xcode instead of CLI

---

## Resources

- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)

---

**Congratulations! Your app is on the App Store! 🎉**
