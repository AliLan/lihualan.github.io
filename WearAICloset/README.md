# WearAICloset

WearAICloset is a SwiftUI iOS app for organizing your wardrobe, generating outfit ideas, and saving favorites. It uses Firebase (Auth, Firestore, Storage) for anonymous sign-in and data storage.

## Features
- Closet management: upload items with photos, categorize them, and view item details.
- Outfit generation: pick a mood and occasion to generate 3–5 outfit suggestions.
- Favorites: save generated outfits, browse favorites, and delete outfits.
- Settings: view account info, app version, and clear your data.

## Requirements
- Xcode 15+
- Swift 5.9+
- iOS 17+
- Firebase project with Authentication, Firestore, and Storage enabled

## Run the App
1. Open `WearAICloset/WearAICloset.xcodeproj` in Xcode.
2. Select an iOS 17+ simulator or device.
3. Press **Run** (⌘R).

## Firebase Setup
1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a project.
2. Add an iOS app with the bundle ID `com.example.WearAICloset` (or change it in Xcode to match your app).
3. Enable **Anonymous** sign-in:
   - Authentication → Sign-in method → Anonymous → Enable
4. Enable **Cloud Firestore**:
   - Build → Firestore Database → Create database → Start in test mode (for local testing)
5. Enable **Storage**:
   - Build → Storage → Get started
6. Download `GoogleService-Info.plist`.
7. Place `GoogleService-Info.plist` in `WearAICloset/WearAICloset/` and add it to the **WearAICloset** target in Xcode.

## Security Rules (MVP)
Restrict data access to each user’s own documents under `users/{uid}`.

**Firestore**
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/items/{itemId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /users/{userId}/outfits/{outfitId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

**Storage**
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/items/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Architecture
- **MVVM**: SwiftUI views bind to observable view models.
- **Repository**: data access via Firestore/Storage repositories.
- **Services**: Firebase bootstrap, auth, and cleanup services.

## Project Structure
- `Views/` — SwiftUI screens and flows.
- `ViewModels/` — MVVM view models.
- `Models/` — Data models and enums.
- `Repositories/` — Firestore/Storage access.
- `Services/` — Firebase bootstrap, auth, and rule engine.
- `Components/` — Reusable UI components.
- `Utilities/` — Helpers for storage and image processing.

## Future Extensions
- LLM-powered styling recommendations backed by a server API.
- Automatic category detection (Vision + ML model).
- Subscription tiers for advanced features and wardrobe analytics.
