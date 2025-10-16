# SM Task - Flutter Assignment Project

A comprehensive Flutter project demonstrating modern app development practices including UI design implementation, REST API integration, state management, and offline capabilities.

## 📋 Project Overview

This project contains three separate assignments, each implemented in its own git branch:

1. **Assignment 1**: Figma Design Implementation with BloC & Reusable Widgets
2. **Assignment 2**: REST API Integration with BLoC State Management
3. **Assignment 3**: Offline Capabilities with Hive Local Storage

---

## 🌿 Branch Structure

| Branch         | Assignment                  | Technologies               |
| -------------- | --------------------------- | -------------------------- |
| `assignment-1` | Figma Design Implementation | BloC, Reusable Widgets     |
| `assignment-2` | REST API Integration        | BLoC, Dio, JSONPlaceholder |
| `assignment-3` | Offline Capabilities        | BLoC, Hive, Dio            |

---

## 🚀 How to Test Each Assignment

### Prerequisites

Before testing any assignment, ensure you have:

```bash
# Flutter SDK installed (v3.8.1 or higher)
flutter --version

# Dependencies installed
flutter pub get

# Check for any issues
flutter doctor
```

---

## 📱 Assignment 1: Figma Design Implementation

### Branch: `assignment-1`

**Objective**: Design implementation from Figma with GetX state management and reusable widget components.

**Figma Design**: [Test Task Design](https://www.figma.com/design/MEnxkKPimzyvroGx9Vwtca/Test-Task?node-id=0-1&p=f&t=OwiTMh5phmHzgkJP-0)

### Testing Instructions:

```bash
# 1. Switch to assignment-1 branch
git checkout assignment-1

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Features to Test:

✅ **Splash Screen**

- Car icon with loading animation
- Auto-navigates to onboarding (first time) or sign-in (returning users)

✅ **Onboarding Flow** (3 Pages)

- Smooth page indicator with Worm effect
- Skip button on pages 1-2
- "Get Started" button on final page
- Pixel-perfect design matching Figma

✅ **Authentication Screens**

- **Sign In**: Email/password with validation, "Remember Me" checkbox
- **Sign Up**: Full registration with password strength indicator
- **Forgot Password**: Email entry for password reset
- **Reset Password**: New password with validation
- **OTP Verification**: 4-digit code with auto-advance, countdown timer

✅ **Post-Auth Screens**

- **Enable Location**: Location permission request
- **Select Language**: 6 languages with flag icons (English, Indonesia, Afghanistan, Algeria, Malaysia, Arabic)

✅ **Reusable Components**

- Primary Button
- Custom Text Field
- Password Text Field with strength indicator
- Custom Checkbox
- Circular Back Button
- OTP Input Field
- Language Selection Item
- Success Dialog (customizable image)

✅ **State Management**

- GetX for reactive state management
- SharedPreferences for onboarding completion persistence

### Expected Flow:

```
Splash → Onboarding (3 pages) → Sign In → Enable Location → Select Language
```

---

## 🌐 Assignment 2: REST API Integration

### Branch: `assignment-2`

**Objective**: Fetch and display data from a REST API using BLoC pattern.

**API**: JSONPlaceholder - `https://jsonplaceholder.typicode.com/posts`

### Testing Instructions:

```bash
# 1. Switch to assignment-2 branch
git checkout assignment-2

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Features to Test:

✅ **Posts Screen**

- Fetches 100 posts from JSONPlaceholder API
- Displays in scrollable ListView
- Each post shows: ID badge, User ID, Title, and Body preview

✅ **Loading States**

- Loading spinner while fetching data
- Smooth transitions between states

✅ **Pull-to-Refresh**

- Pull down to refresh posts
- Updates data from API

✅ **Error Handling**

- Error screen with icon and message
- "Try Again" button to retry fetch

✅ **Empty State**

- Shows inbox icon when no posts available
- "No posts available" message

✅ **Reusable Components**

- Post Item Widget (card design with shadows)

✅ **State Management**

- BLoC pattern with:
  - `FetchPosts` event
  - `RefreshPosts` event
  - `PostsLoading`, `PostsLoaded`, `PostsError` states

✅ **API Integration**

- Dio HTTP client
- Error handling for timeouts and connection issues
- Proper data parsing with Post model

### Navigation Flow:

```
... → Select Language → [Continue] → Posts Screen
```

### Testing Scenarios:

1. **Normal Load**: Posts should load and display
2. **Pull Refresh**: Pull down to refresh posts
3. **Network Error**: Turn off internet to see error handling
4. **Retry**: Click "Try Again" on error screen

---

## 💾 Assignment 3: Offline Capabilities

### Branch: `assignment-3`

**Objective**: Implement offline capabilities with local storage using Hive and BLoC.

### Testing Instructions:

```bash
# 1. Switch to assignment-3 branch
git checkout assignment-3

# 2. Install dependencies
flutter pub get

# 3. Generate Hive adapters (if needed)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Features to Test:

✅ **Online Mode** (Internet Connected)

- Fetches posts from JSONPlaceholder API
- Automatically caches data to Hive local database
- Displays fresh data
- No offline banner visible

✅ **Offline Mode** (No Internet)

- Automatically loads cached data from Hive
- Shows orange "Offline Mode" banner at top
- Banner displays cache age (e.g., "5 minutes ago")
- "Retry" button in banner
- Pull-to-refresh keeps showing cached data

✅ **Cache Management**

- Cache validity: 1 hour
- Automatic cache updates on successful API calls
- Cache persists across app restarts
- Cache timestamp tracking

✅ **Smart Fallback**

- Tries API first
- Falls back to cache on network failure
- Shows cached data with visual indicator
- Graceful error handling

✅ **UI Indicators**

- **Offline Banner**: Orange background, WiFi-off icon, cache age
- **Error Screen**: "Try Again" + "Load Cache" buttons (when cache exists)
- **Loading States**: Spinner during fetch operations

✅ **State Management**

- BLoC with enhanced states:
  - `PostsLoaded` (with `isFromCache` flag)
  - `PostsLoadedFromCache` (with timestamp)
  - `PostsError` (with `hasCachedData` flag)
- Events: `FetchPosts`, `RefreshPosts`, `LoadCachedPosts`

✅ **Local Database**

- Hive NoSQL database
- Post model with type adapter
- Metadata box for cache timestamps
- Cache operations: save, retrieve, validate, clear

### Testing Scenarios:

#### Test 1: First Load (Online)

```bash
1. Ensure device has internet
2. Navigate to Posts screen
3. ✅ Posts load from API
4. ✅ Data cached automatically
5. ✅ No offline banner
```

#### Test 2: Offline with Cache

```bash
1. Load posts online (creates cache)
2. Turn OFF WiFi/Mobile data
3. Close and reopen app
4. Navigate to Posts screen
5. ✅ Cached posts display
6. ✅ Orange "Offline Mode" banner appears
7. ✅ Shows cache age (e.g., "2 minutes ago")
```

#### Test 3: Pull-to-Refresh Offline

```bash
1. In offline mode with cached data
2. Pull down to refresh
3. ✅ Refresh fails (no internet)
4. ✅ Cached data remains
5. ✅ Orange banner stays visible
```

#### Test 4: Retry While Offline

```bash
1. In offline mode
2. Click "Retry" button in banner
3. ✅ Attempts to fetch from API
4. ✅ Falls back to cache
5. ✅ Banner remains
```

#### Test 5: Back Online

```bash
1. While viewing cached data
2. Turn ON WiFi/Mobile data
3. Pull to refresh OR tap "Retry"
4. ✅ Fresh data loads from API
5. ✅ Orange banner disappears
6. ✅ Cache updates with new data
```

#### Test 6: No Cache Available

```bash
1. Clear app data (Settings → Apps → Clear Data)
2. Turn OFF internet
3. Open app and go to Posts screen
4. ✅ Error screen shows
5. ✅ Only "Try Again" button (no "Load Cache")
6. ✅ Error message about no connection
```

#### Test 7: Cache Age Display

```bash
1. Load posts online
2. Wait 30 minutes
3. Turn OFF internet
4. Reopen Posts screen
5. ✅ Banner shows "30 minutes ago"
6. Time formats:
   - "just now" (< 1 min)
   - "X minutes ago"
   - "X hours ago"
   - "X days ago"
```

### Debug Console Messages:

When testing, watch for these logs:

```
✅ Cached 100 posts to local database
📦 Retrieved 100 posts from cache
⏰ Cache is valid (age: 25 minutes)
⏰ Cache is expired (age: 65 minutes)
🗑️ Cache cleared
```

### Navigation Flow:

```
... → Select Language → [Continue] → Posts Screen
                                     ↓
                            (Offline/Online handling)
```

---

## 📚 Additional Documentation

For Assignment 3, see these detailed guides:

- **`OFFLINE_IMPLEMENTATION.md`** - Complete implementation details
- **`TESTING_GUIDE.md`** - Comprehensive testing scenarios

---

## 🛠️ Technologies Used

### Assignment 1:

- **State Management**: GetX
- **UI**: Flutter Material Design 3
- **Storage**: SharedPreferences
- **Animations**: flutter_spinkit, smooth_page_indicator

### Assignment 2:

- **State Management**: flutter_bloc + equatable
- **HTTP Client**: Dio
- **API**: JSONPlaceholder
- **UI**: Flutter Material Design 3

### Assignment 3:

- **State Management**: flutter_bloc + equatable
- **HTTP Client**: Dio
- **Local Database**: Hive + hive_flutter
- **Code Generation**: build_runner + hive_generator
- **API**: JSONPlaceholder
- **UI**: Flutter Material Design 3

---

## 📦 Dependencies

### Core Dependencies (All Branches):

```yaml
flutter_spinkit: ^5.2.2
smooth_page_indicator: ^1.2.1
shared_preferences: ^2.5.3
cupertino_icons: ^1.0.8
```

### Assignment 2 & 3 Additional:

```yaml
flutter_bloc: ^8.1.6
equatable: ^2.0.5
dio: ^5.7.0
```

### Assignment 3 Additional:

```yaml
hive: ^2.2.3
hive_flutter: ^1.1.0
path_provider: ^2.1.5

# Dev dependencies:
hive_generator: ^2.0.1
build_runner: ^2.4.13
```

---

## 🏗️ Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
│   ├── onboarding_data.dart
│   ├── language_option.dart
│   └── post.dart               # (Assignment 2 & 3)
├── screens/                     # UI screens
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── signin_screen.dart
│   ├── signup_screen.dart
│   ├── forgot_password_screen.dart
│   ├── reset_password_screen.dart
│   ├── verify_code_screen.dart
│   ├── enable_location_screen.dart
│   ├── select_language_screen.dart
│   └── posts_screen.dart       # (Assignment 2 & 3)
├── widgets/                     # Reusable components
│   ├── onboarding_page_widget.dart
│   ├── primary_button.dart
│   ├── custom_text_field.dart
│   ├── password_text_field.dart
│   ├── custom_checkbox.dart
│   ├── circular_back_button.dart
│   ├── success_dialog.dart
│   ├── otp_input_field.dart
│   ├── language_selection_item.dart
│   └── post_item_widget.dart   # (Assignment 2 & 3)
├── states/                        # BLoC state management (Assignment 2 & 3)
│   ├── onboarding/
│   │   ├── onboarding_bloc.dart
│   │   ├── onboarding_event.dart
│   │   └── onboarding_state.dart
│   └── posts/
│       ├── posts_bloc.dart
│       ├── posts_event.dart
│       └── posts_state.dart
└── services/                    # External services (Assignment 2 & 3)
    ├── api_service.dart
    └── local_database_service.dart  # (Assignment 3)
```

---

## 🐛 Troubleshooting

### Issue: Build fails with Hive errors (Assignment 3)

```bash
# Solution: Run build_runner
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: App doesn't show cached data offline

```bash
# Solution: Ensure you loaded data online first to create cache
1. Connect to internet
2. Load posts screen
3. Then test offline mode
```

### Issue: Dependencies not found

```bash
# Solution: Clean and reinstall
flutter clean
flutter pub get
```

### Issue: Hot reload not working

```bash
# Solution: Hot restart
Press 'R' in terminal or use hot restart button
```

---

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS

---

## 📄 Assignment Summary

| Assignment | Branch         | Key Feature             | State Mgmt | Storage           |
| ---------- | -------------- | ----------------------- | ---------- | ----------------- |
| 1          | `assignment-1` | Figma UI Implementation | BloC       | SharedPreferences |
| 2          | `assignment-2` | REST API Fetching       | BLoC       | None              |
| 3          | `assignment-3` | Offline Capabilities    | BLoC       | Hive              |

---

## 🎯 Testing Checklist

### Assignment 1:

- [ ] Splash screen displays and navigates
- [ ] Onboarding shows on first launch
- [ ] Skip and Get Started buttons work
- [ ] Sign In/Sign Up forms validate properly
- [ ] Password recovery flow works
- [ ] OTP verification functions
- [ ] Location and Language screens display
- [ ] All reusable widgets work correctly

### Assignment 2:

- [ ] Posts load from API
- [ ] Loading spinner shows during fetch
- [ ] Pull-to-refresh works
- [ ] Error handling shows correctly
- [ ] Retry button functions
- [ ] Post items display properly

### Assignment 3:

- [ ] Posts load and cache online
- [ ] Offline banner appears when offline
- [ ] Cached data displays offline
- [ ] Cache timestamp is accurate
- [ ] Retry button works
- [ ] Pull-to-refresh works offline
- [ ] Fresh data loads when back online
- [ ] Cache persists across app restarts

---

## 👨‍💻 Development

```bash
# Clone the repository
git clone <repository-url>
cd sm_task

# Checkout desired assignment branch
git checkout assignment-1  # or assignment-2, assignment-3

# Install dependencies
flutter pub get

# Run the app
flutter run

# Run tests (if available)
flutter test
```

---

## 📞 Support

For issues or questions about any assignment:

1. Check the branch-specific documentation
2. Review the testing guides
3. Check debug console for error messages
4. Verify all dependencies are installed

---

## 📜 License

This project is created for educational purposes as part of Flutter development assignments.

---

**Happy Testing! 🚀**
