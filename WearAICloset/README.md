# WearAICloset

## Open in Xcode & Run
1. Open `WearAICloset/WearAICloset.xcodeproj` in Xcode 15+.
2. Select an iOS Simulator (iOS 17+) or a connected device.
3. Press **Run** (⌘R).

## Firebase Setup (Auth + Firestore + Storage)
1. Create a Firebase project in the Firebase Console.
2. Add an iOS app with the bundle ID `com.example.WearAICloset` (or update the bundle ID in Xcode to match your app).
3. Enable **Anonymous** sign-in in **Authentication → Sign-in method**.
4. Enable **Cloud Firestore** and **Storage** in the Firebase Console.
5. Download `GoogleService-Info.plist`.
6. Place `GoogleService-Info.plist` in `WearAICloset/WearAICloset/` and add it to the **WearAICloset** target in Xcode.

## Project Structure
- `WearAICloset/` (app sources)
  - `Views/` — SwiftUI screens for the TabView app.
  - `ViewModels/` — MVVM view models with injectable dependencies.
  - `Models/` — Core data models and enums.
  - `Repositories/` — Repository protocols and mock implementations.
  - `Services/` — Service protocols and placeholder implementations.
  - `Components/` — Shared UI components.
