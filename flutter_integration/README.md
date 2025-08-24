# Flutter integration for Sombola

Copy these files into your existing Flutter project under `lib/`:
- `lib/config/api_config.dart`
- `lib/services/api_service.dart`
- `lib/pages/home_page.dart`
- `lib/pages/about_page.dart`
- `lib/widgets/detect_result_card.dart`
- `lib/main.dart` (replace or merge with your existing one)

Update `pubspec.yaml` with the dependencies listed in `pubspec_additions.yaml`.

Run the app:
```bash
flutter pub get
flutter run --dart-define=SOMBOLA_API_BASE_URL=http://localhost:8000
```

Your app will be ready to capture or upload an image and call the backend at `/api/detect`.