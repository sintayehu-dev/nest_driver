# Technology Stack

## Framework & Language
- **Flutter 3.6.2+** with Dart 3+
- Multi-platform support (iOS, Android, Web, Desktop)

## Architecture
- **Clean Architecture** with feature-first organization
- **BLoC Pattern** for state management (flutter_bloc 8.1.6+)
- **Dependency Injection** using get_it + injectable
- **Value Objects** with freezed for immutable data structures

## Key Dependencies
- **State Management**: flutter_bloc, bloc, equatable
- **Navigation**: go_router 14.7+
- **Network**: dio 5.8+, connectivity_plus
- **Storage**: shared_preferences
- **UI/UX**: flutter_screenutil, google_fonts, flutter_svg, shimmer
- **Utilities**: dartz (functional programming), intl (internationalization)
- **Development**: freezed, json_annotation, injectable_generator

## Code Generation
- **freezed**: Immutable classes and unions
- **json_serializable**: JSON serialization
- **injectable**: Dependency injection
- **build_runner**: Code generation orchestration

## Common Commands

### Setup & Dependencies
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Development
```bash
# Run in development mode
flutter run -t lib/main_dev.dart

# Run in staging mode  
flutter run -t lib/main_staging.dart

# Run in production mode
flutter run -t lib/main_prod.dart
```

### Code Generation
```bash
# Generate code (freezed, json_serializable, injectable)
dart run build_runner build --delete-conflicting-outputs

# Watch for changes and regenerate
dart run build_runner watch --delete-conflicting-outputs
```

### Testing
```bash
flutter test
```

### Build
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## Environment Configuration
- Three environments: development, staging, production
- Environment-specific entry points: `main_dev.dart`, `main_staging.dart`, `main_prod.dart`
- Configuration managed in `core/config/environment.dart`