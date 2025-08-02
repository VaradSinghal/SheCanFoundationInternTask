# Fundraising Intern Portal

A Flutter application simulating a fundraising intern portal with a clean, responsive UI. The app uses **mock data** (no backend integration) and includes features like login/sign-up, a dashboard with donation tracking, a leaderboard, announcements, and a fund-adding page. It uses **BLoC** for state management, animations for smooth transitions, and Google Fonts for modern typography.

---

## Features

- **Login & Sign-Up Pages**  
  UI-only forms for user login and sign-up with fields for email, password, and name (Sign-Up only).

- **Dashboard**  
  Displays intern's name, referral code, total donations, and rewards (badges). Includes navigation to other pages.

- **Add Funds Page**  
  Allows users to simulate donations. Total donations and badge statuses are updated accordingly.

- **Leaderboard**  
  Lists top fundraisers with donation scores and unlocked badges.

- **Announcements**  
  Static messages about campaign updates.

- **Badges System**
  - **Bronze:** ₹1,000 (#CD7F32)
  - **Silver:** ₹5,000 (#C0C0C0)
  - **Gold:** ₹10,000 (#FFD700)
  - Visual feedback with `Icons.lock` (locked) and `Icons.lock_open` (unlocked)

- **Animations**
  - Scale transitions for page entry
  - Slide transitions for navigation

- **Responsive UI**
  - Neumorphic cards
  - Blue-gray theme: `#4A90E2`, `#F5F7FA`
  - Google Fonts (Poppins)

- **State Management**
  - Implemented using `flutter_bloc` and mock data

---

## 📁 Folder Structure
she_can_found_intern/
├── lib/
│ ├── bloc/
│ │ ├── app_bloc.dart
│ │ ├── app_event.dart
│ │ ├── app_state.dart
│ ├── models/
│ │ ├── user_model.dart
│ │ ├── leaderboard_entry.dart
│ │ ├── reward_model.dart
│ ├── pages/
│ │ ├── login_page.dart
│ │ ├── signup_page.dart
│ │ ├── dashboard_page.dart
│ │ ├── add_funds_page.dart
│ │ ├── leaderboard_page.dart
│ │ ├── announcements_page.dart
│ ├── main.dart
├── pubspec.yaml
├── README.md


- `bloc/`: State management using BLoC
- `models/`: Data models (User, LeaderboardEntry, Reward)
- `pages/`: UI screens for each feature
- `main.dart`: App entry point
- `pubspec.yaml`: Dependencies

---

## 🛠 Prerequisites

- **Flutter SDK:** `>=3.0.0 <4.0.0`
- **Dart SDK:** Included with Flutter
- **IDE:** VS Code or Android Studio (recommended)
- **Device:** Emulator or physical device for testing

---

## 🔧 Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd she_can_found_intern

