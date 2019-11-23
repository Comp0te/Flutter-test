# Test application on Flutter

![](https://github.com/Comp0te/Flutter-test/workflows/Code%20check/badge.svg?branch=dev)

## Table of contents:

- [Getting Started](#getting-started)
- [Used technologies:](#used-technologies)

### Getting Started

 1. Clone repository
 2. `flutter pub get`
 4. Add `google-services.json` to `android/app/` folder
 5. Rename `android/app/src/main/res/values/secrets_example.xml` to `secrets.xml` and add your google_maps_api_key
 6. Add `GoogleService-Info.plist` to ios folder
 7. Rename `ios/Runner/secrets-example.swift` to `secrets.swift` and add your google_maps_api_key
 8. Look in the `scripts/` folder to add git hooks

### Used technologies:

- **Platforms:**
    - Android
    - IOS
    - Web - TODO
- **Networking**
    - REST
    - `dio`
    - processing JSON: `json_annotation`, `json_serializable`, `build_runner`
    - `cached_network_image`
- **Authentication:**
	- Back-end API with usage of JWT token
	- Google login using Back-end API - `google_sign_in`
	- Facebook login - `flutter_facebook_login` (currently only flutter_facebook_login usage, backend API not working)
	- TouchId/FaceId - `local_auth` - TODO
- **Architecture:**
	- Bloc: `bloc`, `flutter_bloc`, `equatable`
	- Bloc`s code generation - TODO
- **Camera:**
    - Photo and video shooting - `camera`
    - Playing video - `video_player`
- **Push Notifications**
    - `firebase_messaging`
- **Maps**
    - `google_maps_flutter`
    - `geolocator`
- **Forms**
    - `flutter_form_builder`
- **Database:**
    - `sqflite`,
    - `shared_preferences`,
    - `flutter_secure_storage`
    - Decoding and saving images to disk: `path`, `path_provider`, `flutter_cache_manager`, `image`
- **Animations**
    - `page_transition`
    - Flutter built-in animations
- **Theming**
    - Light and Dark mode.
- **Localization**
    - En, Ru - `flutter_localizations`, `intl` + [Flutter i18n plugin for Android studio](https://plugins.jetbrains.com/plugin/10128-flutter-i18n/)
- **Other features**
    - List with infinite scroll
- **Code quality tools**
    - `pedantic` + custom rules in the `analysis_options.yaml`
    - pre-commit, pre-push git-hooks
    - CI - Github actions
    - unit tests - TODO
---
