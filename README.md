## Base Arc – Flutter Clean Architecture Template 🚀

Production-ready Flutter starter with clean architecture, strong feature boundaries, and great DX.

[![Flutter](https://img.shields.io/badge/Flutter-3%2B-blue?logo=flutter)](https://flutter.dev) [![Dart](https://img.shields.io/badge/Dart-3%2B-0175C2?logo=dart)](https://dart.dev) [![Architecture](https://img.shields.io/badge/Architecture-Clean-success)](#) [![License](https://img.shields.io/badge/License-MIT-black)](#)

### ✨ What you get
- **Scalable features**: feature-first modules with clear boundaries
- **Clean layers**: presentation → application → domain ← infrastructure
- **Testable by design**: interfaces, value objects, and DI
- **Great DX**: codegen, linting, conventions, and tooling

### 🧭 Structure
```
lib/
├─ core/        # DI, routing, services, theme, utils
├─ features/    # Bounded contexts (e.g., auth, main)
└─ main.dart    # Entry point
```

### ⚙️ Quick start
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### 🧩 Tech
- **Navigation**: go_router
- **DI**: get_it + injectable
- **State**: flutter_bloc + freezed
- **Network/Storage/UI**: dio, shared_preferences, google_fonts, screenutil, svg, shimmer

### 🏗️ Principles
- Feature-first over layer-first
- Value Objects protect invariants
- Side effects isolated in infrastructure

### 🔌 DI & Routing
- Initialize in `core/di/dependancy_manager.dart` via `GetIt.instance.init()`
- Routes centralized in `core/router/router.dart` with `RouteName`

---

Made with ❤️ to help teams ship fast and keep code clean.
